
from datetime import datetime
import logging
from time import time
from uuid import uuid4, UUID
from sqlalchemy.orm import Session
from src.models import InterviewSession, TeacherResponse
from typing import Optional
from src.usecases.websocket_connection.connection_managemet import get_connection_by_user_id
from socketio import AsyncServer
from langchain_core.pydantic_v1 import BaseModel, Field
from langchain_community.chat_message_histories import ChatMessageHistory
from langchain_core.chat_history import BaseChatMessageHistory
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
from langchain.chains import create_history_aware_retriever, create_retrieval_chain
from langchain_core.runnables.history import RunnableWithMessageHistory
from huggingface_hub import hf_hub_download
# from langchain_community.llms import LlamaCpp
from langchain_community.chat_models import ChatLlamaCpp
from langchain_community.vectorstores import Chroma
# from langchain_community.embeddings import HuggingFaceEmbeddings
from langchain_community.document_loaders import WebBaseLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnableParallel, RunnablePassthrough, RunnableLambda
from langchain_huggingface import HuggingFaceEmbeddings
import bs4
from langchain import hub


### Statefully manage chat history ###
chat_history_store = {}


def start_interview(session: Session, user_id: UUID, teacher_id: UUID, delete_current_interview: bool = True):
    current_interview_query = session.query(
        InterviewSession).where(InterviewSession.user_id == user_id and InterviewSession.done == False)
    current_interview: Optional[InterviewSession] = session.execute(
        current_interview_query).first()[0]
    if current_interview and delete_current_interview:
        finish_interview(session, current_interview)
        session.commit()
    elif current_interview:
        raise Exception(
            "The user {} are already in an interview session.".format(user_id))
    interview_session = InterviewSession(
        id=uuid4(),
        user_id=user_id,
        teacher_id=teacher_id,
        start_at=datetime.now(),
        progress=1,
        done=False
    )
    session.add(interview_session)
    session.commit()
    return interview_session


def finish_interview(session: Session, interview_session: InterviewSession):
    interview_session.done = True
    session.commit()
    del chat_history_store[interview_session.id]


def speak_to_teacher(session: Session, interview_session: InterviewSession, message_from_user: str):
    if interview_session.done:
        raise Exception("The interview session is already done.")
    response_from_teacher = generate_message_from_teacher(
        interview_session, message_from_user)
    return TeacherResponse(message=response_from_teacher)


def generate_message_from_teacher(interview_session: InterviewSession, message: str):
    CONTEXT_SIZE = 4096
    LLM_FILE = "src/llm/ELYZA-japanese-Llama-2-7b-instruct-q2_K.gguf"
    CHUNK_SIZE = 256
    CHUNK_OVERLAP = 64
    EMB_MODEL = "sentence-transformers/distiluse-base-multilingual-cased-v2"
    COLLECTION_NAME = "langchain"
    url = "https://www.kanazawa-it.ac.jp/campus_guide/2024/chapter_3/list_1/page_9.html"
    loader = WebBaseLoader(web_path=url,
                           bs_kwargs=dict(parse_only=bs4.SoupStrainer(
                               class_=("list_title", "cnt_block")
                           ))
                           )
    docs = loader.load()
    text_splitter = RecursiveCharacterTextSplitter(
        chunk_size=1000, chunk_overlap=200)
    splits = text_splitter.split_documents(docs)
    embeddings = HuggingFaceEmbeddings(model_name=EMB_MODEL)
    vectorstore = Chroma.from_documents(
        documents=splits, embedding=embeddings)
    retriever = vectorstore.as_retriever()
    # prompt = hub.pull("rlm/rag-prompt")

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
    あなたは学生の就学アドバイザーです。
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


def get_session_history(session_id: str) -> BaseChatMessageHistory:
    if session_id not in chat_history_store:
        chat_history_store[session_id] = ChatMessageHistory()
    print("これがhistory_store", chat_history_store[session_id])
    return chat_history_store[session_id]
