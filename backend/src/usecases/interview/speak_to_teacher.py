
import os
from typing import Any, Dict, List, Optional
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
from src.models import InterviewSessionModel, InterviewRecordModel, TeacherResponse, InterviewQuestionModel, InterviewQuestion, SchoolCredit, Gpa, AttendanceRate, Concern, PreferInPerson, ExtractionResult, TeacherModel
from dotenv import load_dotenv
from sqlalchemy.orm import Session
from src.usecases.interview.finish_interview import finish_interview


OPENAI_API_KEY = os.getenv('OPENAI_API_KEY')


# 会話の履歴を保持するためのdict（一旦メモリ上に保持）
chat_history_store = {}

# 質問たちはそんなにないので、一度取得したらキャッシュしておく
questions: Dict[int, InterviewQuestion] = {}

# RAGのベクトルストア。（念のためにグローバル変数としてメモリ上にキャッシュ）
# TODO:　ファイルとかRedisとかに保存することを検討
vectorstore: Optional[Chroma] = None


def get_questions(session: Session):
    if len(questions.keys()) > 0:
        return questions
    question_query = session.query(InterviewQuestionModel)
    all_questions: List[InterviewQuestionModel] = session.execute(
        question_query).scalars().all()
    for question in all_questions:
        questions[question.order] = TypeAdapter(
            InterviewQuestion).validate_python(question.__dict__)
    return questions


def speak_to_teacher(db_session: Session, interview_session: InterviewSessionModel, message_from_user: str) -> str:
    use_local_llm = bool(int(os.getenv("USE_LOCAL_LLM")))
    if interview_session.done:
        raise Exception("The interview session is already done.")
    questions = get_questions(db_session)
    extraction_result = extract_answer(
        interview_session, message_from_user, questions)
    if extraction_result.succeeded_to_extract:
        interview_record_query = db_session.query(InterviewRecordModel).where(
            InterviewRecordModel.session_id == interview_session.id)
        interview_records = db_session.execute(interview_record_query).first()
        if not interview_records:
            raise Exception("The interview record is not found.")
        interview_record: InterviewRecordModel = interview_records[0]
        match interview_session.progress:
            case 1:
                interview_record.total_earned_credits = extraction_result.extracted_value
            case 2:
                interview_record.planned_credits = extraction_result.extracted_value
            case 3:
                interview_record.gpa = extraction_result.extracted_value
            case 4:
                interview_record.attendance_rate = extraction_result.extracted_value
            case 5:
                interview_record.concern = extraction_result.extracted_value
            case 6:
                interview_record.prefer_in_person_interview = extraction_result.extracted_value
        interview_session.progress += 1
        if interview_session.progress > 6:
            interview_session.progress = 6
            finish_interview(db_session, interview_session,
                             chat_history_store=chat_history_store, interview_record=interview_record)
            # TODO: この返答雑すぎるので、もう少し工夫する。（ここもLLM使って生成したい）
            return "面談はこれで終了です。ありがとうございました。"
        db_session.commit()
    message_from_teacher = generate_message_from_teacher(
        db_session, interview_session, message_from_user, use_local_llm)
    return message_from_teacher


def generate_message_from_teacher(db_session: Session, interview_session: InterviewSessionModel, message_from_student: str, use_local_llm: bool = False):
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

    current_question = get_questions(db_session)[interview_session.progress]

    if use_local_llm:
        llm = ChatLlamaCpp(
            model_path=LLM_FILE,
            n_gpu_layers=128,
            n_ctx=CONTEXT_SIZE,
            f16_kv=True,
            verbose=True,
            seed=0
        )

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


def extract_answer(interview_session: InterviewSessionModel, message_from_student: str, questions: Dict[int, InterviewQuestion]):
    current_question = questions[interview_session.progress]
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
        model_name="gpt-3.5-turbo",
        openai_api_key=OPENAI_API_KEY
    )

    structured_output_class: Any = None

    match interview_session.progress:
        case 1:
            structured_output_class = SchoolCredit
        case 2:
            structured_output_class = SchoolCredit
        case 3:
            structured_output_class = Gpa
        case 4:
            structured_output_class = AttendanceRate
        case 5:
            structured_output_class = Concern
        case 6:
            structured_output_class = PreferInPerson

    chain = prompt | llm.with_structured_output(structured_output_class)
    response = chain.invoke({"text": message_from_student},
                            config={"callbacks": [ConsoleCallbackHandler()]}).dict()
    retrievedValue = None
    print("れすぽんす", response)
    match interview_session.progress:
        case 1:
            retrievedValue = response['credit']
        case 2:
            retrievedValue = response['credit']
        case 3:
            retrievedValue = response['gpa']
        case 4:
            retrievedValue = response['attendance_rate']
        case 5:
            retrievedValue = response["trouble"]
        case 6:
            retrievedValue = response["prefer_in_person"]

    return ExtractionResult(
        interview_session=interview_session,
        succeeded_to_extract=False if retrievedValue is None else True,
        extracted_value=retrievedValue
    )
