
from datetime import datetime
import logging
import os
from time import time
from uuid import uuid4, UUID
from dotenv import load_dotenv
from sqlalchemy.orm import Session
from src.models import InterviewSessionModel, TeacherResponse, InterviewQuestionModel, InterviewQuestion, SchoolCredit, Gpa, AttendanceRate, Trouble, PreferInPerson, ExtractionResult, TeacherModel
from typing import Any, Dict, List, Optional
from src.usecases.websocket_connection.connection_managemet import get_connection_by_user_id
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


def start_interview(session: Session, user_id: UUID, teacher_id: UUID, delete_current_interview: bool = True):
    current_interview_query = session.query(
        InterviewSessionModel).join(TeacherModel, InterviewSessionModel.teacher_id == TeacherModel.id).where(InterviewSessionModel.user_id == user_id and InterviewSessionModel.done == False)
    current_interview_rows: Optional[InterviewSessionModel] = session.execute(
        current_interview_query).first()
    current_interview = current_interview_rows[0] if current_interview_rows else None
    if current_interview and delete_current_interview:
        finish_interview(session, current_interview)
        session.commit()
    elif current_interview_rows:
        raise Exception(
            "The user {} are already in an interview session.".format(user_id))
    interview_session = InterviewSessionModel(
        id=uuid4(),
        user_id=user_id,
        teacher_id=teacher_id,
        start_at=datetime.now(),
        progress=1,
        done=False
    )
    session.add(interview_session)
    session.commit()
    current_interview_rows: Optional[InterviewSessionModel] = session.execute(
        current_interview_query).first()
    current_interview = current_interview_rows[0] if current_interview_rows else None
    return current_interview


def finish_interview(session: Session, interview_session: InterviewSessionModel):
    interview_session.done = True
    session.commit()
    store_key = interview_session.id.__str__()
    if store_key in chat_history_store:
        del store_keychat_history_storne


load_dotenv(".env.local")

OPENAI_API_KEY = os.getenv('OPENAI_API_KEY')


# 会話の履歴を保持するためのdict（一旦メモリ上に保持）
chat_history_store = {}


questions: Dict[int, InterviewQuestion] = {}


def getQuestions(session: Session):
    if len(questions.keys()) > 0:
        return questions
    question_query = session.query(InterviewQuestionModel)
    all_questions: List[InterviewQuestionModel] = session.execute(
        question_query).scalars().all()
    for question in all_questions:
        questions[question.order] = question
    return questions


def speak_to_teacher(session: Session, interview_session: InterviewSessionModel, message_from_user: str):
    if interview_session.done:
        raise Exception("The interview session is already done.")
    questions = getQuestions(session)
    extraction_result = extract_answer(
        interview_session, message_from_user, questions)
    if not extraction_result.succeeded_to_extract:

    else:
        interview_session.progress += 1
        session.commit()
    response_from_teacher = generate_message_from_teacher(
        interview_session, message_from_user)

    return TeacherResponse(message_from_teacher=response_from_teacher)


def generate_message_from_teacher(interview_session: InterviewSessionModel, message: str):
    CONTEXT_SIZE = 4096
    LLM_FILE = "src/llm/ELYZA-japanese-Llama-2-7b-instruct-q2_K.gguf"
    CHUNK_SIZE = 256
    CHUNK_OVERLAP = 64
    EMB_MODEL = "sentence-transformers/distiluse-base-multilingual-cased-v2"
    COLLECTION_NAME = "langchain"

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
    llm = ChatLlamaCpp(
        model_path=LLM_FILE,
        n_gpu_layers=128,
        n_ctx=CONTEXT_SIZE,
        f16_kv=True,
        verbose=True,
        seed=0
    )
    template = """<s>[INST] <<SYS>>
    あなたは学生の就学アドバイザーです。学生の悩みに対して与えられた情報に基づいて、適切なアドバイスを提供してください。必ず学生の悩みに答えるような回答を心がけてください。
    <</SYS>>
    {context}
    {history}
    [/INST]
    {question}
    </s>"""
    prompt = ChatPromptTemplate.from_template(template)
    # {"question": RunnablePassthrough(), "context": retriever | format_docs}
    rag_chain = (
        {"context": RunnableLambda(lambda x: x['question']) | retriever | format_docs,
         "question": RunnablePassthrough(),
         "history": RunnableLambda(lambda x: x['history'])}
        | prompt
        | llm
        | StrOutputParser()
    )

    def get_session_history(session_id: str) -> BaseChatMessageHistory:
        if session_id not in chat_history_store:
            chat_history_store[session_id] = ChatMessageHistory()
        print("history_store", chat_history_store[session_id])
        return chat_history_store[session_id]

    conversational_rag_chain = RunnableWithMessageHistory(
        rag_chain,
        get_session_history,
        input_messages_key="question",
        history_messages_key="history",
    )

    response = conversational_rag_chain.invoke({"question": message}, config={
        "configurable": {"session_id": interview_session.id.__str__()}})
    vectorstore.delete_collection()
    return response


def extract_answer(interview_session: InterviewSessionModel, message: str, questions: Dict[int, InterviewQuestion]):
    current_question = questions[interview_session.progress]
    prompt_template = current_question.prompt + """。以下の[text]から構造化データとして抽出してください。
    もし抽出できない場合はNoneを入力してください。
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
            structured_output_class = Trouble
        case 6:
            structured_output_class = PreferInPerson

    chain = prompt | llm.with_structured_output(structured_output_class)
    response = chain.invoke({"text": message},
                            config={"callbacks": [ConsoleCallbackHandler()]}).dict()
    retrievedValue = None
    match interview_session.progress:
        case 1:
            retrievedValue = response.credit
        case 2:
            retrievedValue = response.credit
        case 3:
            retrievedValue = response.gpa
        case 4:
            retrievedValue = response.attendance_rate
        case 5:
            retrievedValue = response.trouble
        case 6:
            retrievedValue = response.prefer_in_person

    return ExtractionResult(
        interview_session=interview_session,
        succeeded_to_extract=True if retrievedValue else False,
        extracted_value=retrievedValue
    )
