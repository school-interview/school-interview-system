
import os
from typing import Any, Dict, List, Optional
from uuid import UUID
from langchain_community.chat_message_histories import ChatMessageHistory
from langchain_core.chat_history import BaseChatMessageHistory
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder, HumanMessagePromptTemplate
from langchain_core.runnables.history import RunnableWithMessageHistory
from huggingface_hub import hf_hub_download
from langchain_community.chat_models import ChatLlamaCpp
from langchain_community.vectorstores import Chroma
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnablePassthrough, RunnableLambda
from langchain_huggingface import HuggingFaceEmbeddings
from langchain import hub
from langchain_openai import ChatOpenAI
from langchain.schema import HumanMessage, SystemMessage
from langchain_core.tracers.stdout import ConsoleCallbackHandler
from pydantic import TypeAdapter
from src.models import InterviewSessionModel, InterviewRecordModel, TeacherResponse, InterviewQuestionModel, InterviewQuestion, InterviewQuestionGroupModel, ExtractionResult, TeacherModel, IntExtraction, BoolExtraction, FloatExtraction, StrExtraction
from sqlalchemy.orm import Session
from src.usecases.interview.finish_interview import finish_interview
from src.crud import InterviewQuestionGroupsCrud, InterviewQuestionsCrud, InterviewRecordsCrud

OPENAI_API_KEY = os.getenv('OPENAI_API_KEY')

# 会話の履歴を保持するためのdict（一旦メモリ上に保持）
chat_history_store = {}

# RAGのベクトルストア。（念のためにグローバル変数としてメモリ上にキャッシュ）
# TODO:　ファイルとかRedisとかに保存することを検討
vectorstore: Optional[Chroma] = None

interview_question_groups_crud = InterviewQuestionGroupsCrud(
    InterviewQuestionGroupModel)
interview_questions_crud = InterviewQuestionsCrud(InterviewQuestionModel)
interview_records_crud = InterviewRecordsCrud(InterviewRecordModel)


def speak_to_teacher(db_session: Session, interview_session: InterviewSessionModel, message_from_user: str) -> str:
    USE_LOCAL_LLM = os.getenv("USE_LOCAL_LLM")
    if USE_LOCAL_LLM is None:
        raise Exception(
            "could not load USE_LOCAL_LLM. It's likely because .env file doesn't exist.")
    use_local_llm = bool(int(USE_LOCAL_LLM))
    if interview_session.done:
        raise Exception("The interview session is already done.")
    questions_dict = interview_questions_crud.get_multi_in_dict(db_session)
    extraction_result = extract_value(
        interview_session, message_from_user, questions_dict)
    if extraction_result.succeeded_to_extract:
        interview_groups = interview_question_groups_crud.get_multi_with_questions(
            db_session)
        questions_by_group = interview_question_groups_crud.get_questions_by_group(
            db_session)
        interview_records = interview_records_crud.get_records_by_session_id(
            db_session, interview_session.id)
        interview_session.progress_interview(
            db_session, extraction_result.extracted_value, interview_groups, questions_by_group, interview_records)
        if interview_session.done:
            finish_interview(db_session, interview_session,
                             chat_history_store=chat_history_store)
            # TODO: この返答雑すぎるので、もう少し工夫する。（ここもLLM使って生成したい）
            return "面談はこれで終了です。ありがとうございました。"
        db_session.commit()
    message_from_teacher = generate_message_from_teacher(
        db_session, interview_session, questions_dict, message_from_user, use_local_llm)
    return message_from_teacher


def generate_message_from_teacher(
        db_session: Session,
        interview_session: InterviewSessionModel,
        questions_dict: Dict[UUID, InterviewQuestion],
        message_from_student: str,
        use_local_llm: bool = False
):
    CONTEXT_SIZE = 4096
    LLM_FILE = "src/llm/ELYZA-japanese-Llama-2-7b-instruct-q2_K.gguf"
    CHUNK_SIZE = 256
    CHUNK_OVERLAP = 64
    EMB_MODEL = "sentence-transformers/distiluse-base-multilingual-cased-v2"
    COLLECTION_NAME = "langchain"
    global vectorstore
    if vectorstore is None:
        md_file = ''
        with open("pdf/markdown_output/campusguide.md") as f:
            md_file = f.read()
        text_splitter = RecursiveCharacterTextSplitter(
            chunk_size=1000, chunk_overlap=200)
        splits = text_splitter.split_text(md_file)
        embeddings = HuggingFaceEmbeddings(model_name=EMB_MODEL)
        vectorstore = Chroma.from_texts(
            texts=splits, embedding=embeddings
        )
    retriever = vectorstore.as_retriever(search_kwargs={"k": 2})

    def format_docs(docs):
        return "\n\n".join(doc.page_content for doc in docs)

    def get_session_history(session_id: str) -> BaseChatMessageHistory:
        if session_id not in chat_history_store:
            chat_history_store[session_id] = ChatMessageHistory()
        print("history_store", chat_history_store[session_id])
        return chat_history_store[session_id]

    def generate_prompt_template(current_question: InterviewQuestion):
        common_inst = """
        Infomation on this university(for RAG):'{context}'
        Our chat history: {history}
        What the student said to you(You need to answer for this question): {question}

        Situation: You are professional Academic Advisor who support school life and carrer. Please respond to the student's question. Always try to resolve a problem the student has. And you are designed to utilize information on school(RAG). Please answer based on provided sources.
                
        You are asking this question, [""" + current_question.question + """] to the student and make the student answer your question. You must put the question to the end of your response. It's better to add it with "ところで", "" because it's more natural in Japanese.(Anything is ok. but make it sounds natural in Japanese)

        You must answer as if you are speaking directly to the student.

        You must answer in Japanese.
"""
        template = ""
        if use_local_llm:
            start_llama_inst = "<s>[INST] <<SYS>>"
            end_llama_inst = "<</SYS>>[/INST]"
            template = start_llama_inst + common_inst + \
                end_llama_inst + "学生の発言：{question}"
        else:
            template = common_inst + "学生の発言：{question}"
        return template

    current_question = questions_dict[interview_session.current_question_id]
    if current_question is None:
        raise ValueError("The current question is not loaded.")

    if use_local_llm:
        llm = ChatLlamaCpp(
            model_path=LLM_FILE,
            n_gpu_layers=128,
            n_ctx=CONTEXT_SIZE,
            f16_kv=True,
            verbose=True,
            seed=0
        )  # type: ignore

        prompt_template = generate_prompt_template(current_question)

        prompt = ChatPromptTemplate.from_template(prompt_template)
        rag_chain = (
            {"context": RunnableLambda(lambda x: x['question']) | retriever | format_docs,
             "question": RunnablePassthrough(),
             "history": RunnableLambda(lambda x: x['history'])}
            | prompt
            | llm
            | StrOutputParser()
        )
        conversational_rag_chain = RunnableWithMessageHistory(
            rag_chain,
            get_session_history,
            input_messages_key="question",
            history_messages_key="history",
        )
        response = conversational_rag_chain.invoke({"question": message_from_student}, config={
            "configurable": {"session_id": interview_session.id.__str__()}})
        return response
    else:
        llm = ChatOpenAI(
            temperature=0,
            model_name="gpt-3.5-turbo",
            openai_api_key=OPENAI_API_KEY
        )
        prompt_template = generate_prompt_template(current_question)
        print(prompt_template)
        prompt = ChatPromptTemplate.from_template(
            prompt_template)
        rag_chain = (
            {"context": RunnableLambda(lambda x: x['question']) | retriever | format_docs,
             "question": RunnablePassthrough(),
             "history": RunnableLambda(lambda x: x['history'])}
            | prompt
            | llm
            | StrOutputParser()
        )
        conversational_rag_chain = RunnableWithMessageHistory(
            rag_chain,
            get_session_history,
            input_messages_key="question",
            history_messages_key="history",
        )
        response = conversational_rag_chain.invoke({"question": message_from_student}, config={
            "configurable": {"session_id": interview_session.id.__str__()}})
        return response


def extract_value(
    interview_session: InterviewSessionModel,
    message_from_student: str,
    questions_dict: Dict[UUID, InterviewQuestion]
):
    current_question = questions_dict[interview_session.current_question_id]
    prompt_template = current_question.prompt + """
    Please extract structured data from the following [text]. If extraction is not possible, input 'None'.
    [text]
    {text}
    """
    prompt_msgs = [
        SystemMessage(
            content="You are a world class algorithm for extracting documents in structured formats."
        ),
        HumanMessagePromptTemplate.from_template(prompt_template),
        HumanMessage(
            content="Tips: Make sure to answer in the correct format."),
    ]
    prompt = ChatPromptTemplate(messages=prompt_msgs)
    llm = ChatOpenAI(
        temperature=0,
        model_name="gpt-3.5-turbo",  # type: ignore
        openai_api_key=OPENAI_API_KEY  # type: ignore
    )

    structured_output_class: Any = None

    match current_question.extraction_data_type:
        case 'bool':
            structured_output_class = BoolExtraction
        case 'int':
            structured_output_class = IntExtraction
        case 'float':
            structured_output_class = FloatExtraction
        case 'str':
            structured_output_class = StrExtraction

    chain = prompt | llm.with_structured_output(structured_output_class)
    output: Any = chain.invoke({"text": message_from_student},
                               config={"callbacks": [ConsoleCallbackHandler()]})
    output_dict = output.dict()
    extracted_value = output_dict['extracted_value']

    return ExtractionResult(
        question_id_before_update=current_question.id,
        interview_session=interview_session,
        succeeded_to_extract=False if extracted_value is None else True,
        extracted_value=extracted_value
    )
