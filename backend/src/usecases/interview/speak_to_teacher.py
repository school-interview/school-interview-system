
import os
import re
from typing import Any, Dict, List, Optional, Union, Sequence
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
from langchain_core.prompts import ChatPromptTemplate,PromptTemplate
from langchain_core.runnables import RunnablePassthrough, RunnableLambda
from langchain_huggingface import HuggingFaceEmbeddings
from langchain import hub
from langchain_openai import ChatOpenAI
from langchain.schema import HumanMessage, SystemMessage
from langchain_core.tracers.stdout import ConsoleCallbackHandler
from langchain_community.document_loaders import UnstructuredMarkdownLoader
from langchain_core.messages import BaseMessage
from pydantic import TypeAdapter
from src.models import InterviewSessionModel, InterviewRecordModel, TeacherResponse, InterviewQuestionModel, InterviewQuestion, InterviewQuestionGroupModel, ExtractionResult, TeacherModel, IntExtraction, BoolExtraction, FloatExtraction, StrExtraction
from sqlalchemy.orm import Session
from src.usecases.interview.finish_interview import finish_interview
from src.crud import InterviewQuestionGroupsCrud, InterviewQuestionsCrud, InterviewRecordsCrud
from transformers import AutoModelForCausalLM, AutoTokenizer, pipeline
from pydantic import Field
from langchain_huggingface import HuggingFacePipeline

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


class LimitedChatMessageHistory(ChatMessageHistory):
    max_messages: int = Field(default=2)

    def __init__(self, max_messages=2):
        super().__init__()
        self.max_messages = max_messages

    def add_messages(self, messages: Sequence[BaseMessage]) -> None:
        super().add_messages(messages)
        self._limit_messages()

    def _limit_messages(self):
        if len(self.messages) > self.max_messages:
            self.messages = self.messages[-self.max_messages:]


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
    model_name = "elyza/Llama-3-ELYZA-JP-8B"
    tokenizer = AutoTokenizer.from_pretrained(model_name)
    model = AutoModelForCausalLM.from_pretrained(
        model_name,
        torch_dtype="auto",
        device_map="cuda",
    )
    pipe = pipeline("text-generation", model=model,
                    tokenizer=tokenizer, max_new_tokens=64)

    global vectorstore
    if vectorstore is None:
        markdown_path = "./campusguide-conversation.md"
        markdown_loader = UnstructuredMarkdownLoader(markdown_path)
        index_path = "./storage"

        embedding_model = HuggingFaceEmbeddings(
            model_name="intfloat/multilingual-e5-large"
        )
        split_texts = list(
            markdown_loader.load_and_split(
                text_splitter=RecursiveCharacterTextSplitter(
                    chunk_size=200,
                    chunk_overlap=50
                )
            )
        )

        split_texts = list(map(lambda d: d.page_content, split_texts))

        vectorstore = Chroma.from_texts(
            texts=split_texts, embedding=embedding_model, persist_directory="./"
        )
    retriever = vectorstore.as_retriever(search_kwargs={"k": 2})

    def format_docs(docs):
        return "\n\n".join(doc.page_content for doc in docs)

    global chat_history_store

    def get_session_history(session_id: str) -> BaseChatMessageHistory:
        if session_id not in chat_history_store:
            chat_history_store[session_id] = LimitedChatMessageHistory()
        return chat_history_store[session_id]

    current_question = questions_dict[interview_session.current_question_id]
    if current_question is None:
        raise ValueError("The current question is not loaded.")
    
    llm = HuggingFacePipeline(
        pipeline=pipe
    )
    question_prompt_template_format = tokenizer.apply_chat_template(
        conversation = [
            {"role": "system", "content": """
        
            Situation: You are professional Academic Advisor who support school life and carrer. Please respond to the student's question. Always try to resolve a problem the student has. And you are designed to utilize information on school. Please answer based on provided sources.
            Your question to the student is [""" + current_question.question+ """].
            You must make the user answer your question. You must put the question to the end of your response.  for example, you can put "ところで" and then you can ask the user your question ( [""" + current_question.question+ """])
            You must answer as if you are speaking directly to the student.
            You can't add anything other than your question to your answer.
            You must answer in Japanese. 
            For example, if your question is '現在の単位は幾つですか？', you must answer 'ところで現在の取得単位を押していただけますか？'

            Our chat history: {history}
            Context: {context}
            
            """},
            {"role": "user", "content": "{question}"}
        ], 
        tokenize=False, 
        add_generation_prompt=True
    )
    question_prompt = PromptTemplate(
        template=question_prompt_template_format, # type: ignore
        input_variables=["question"]
    )

    chain = (
        {
        "context": RunnableLambda(lambda x: x['question']) | retriever | format_docs, # type: ignore
        "question": RunnableLambda(lambda x: x['question']), # type: ignore
        "history": RunnableLambda(lambda x: x['history']) # type: ignore
        }
        | question_prompt 
        | llm
    )

    runnnable_with_history = RunnableWithMessageHistory(
        chain,
        get_session_history,
        input_messages_key="question",
        history_messages_key="history",
    )
    response = runnnable_with_history.invoke(
        {"question": message_from_student},
        config={
            "configurable": {
                "session_id": interview_session.id.__str__()
            }
        }
    )
    splits = response.split("\n")
    message = ""
    for s in splits[::-1]:
        if "<|start_header_id|>assistant<|end_header_id|>" in s:
            break
        message+=s
    return message



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
