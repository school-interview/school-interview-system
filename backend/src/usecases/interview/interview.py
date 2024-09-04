
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
from huggingface_hub import hf_hub_download
# from langchain_community.llms import LlamaCpp
from langchain_community.chat_models import ChatLlamaCpp
from langchain_community.vectorstores import Chroma
# from langchain_community.embeddings import HuggingFaceEmbeddings
from langchain_community.document_loaders import WebBaseLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnableParallel, RunnablePassthrough
from langchain_huggingface import HuggingFaceEmbeddings


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


def speak_to_teacher(session: Session, interview_session: InterviewSession, message_from_user: str):
    if interview_session.done:
        raise Exception("The interview session is already done.")
    response = TeacherResponse(message="Hello I am teacher")
    return response


def generate_message_from_teacher(interview_session: InterviewSession, message: str):
    CONTEXT_SIZE = 2048
    LLM_FILE = "../../llm/ELYZA-japanese-Llama-2-7b-instruct-q2_K.gguf"
    CHUNK_SIZE = 256
    CHUNK_OVERLAP = 64
    EMB_MODEL = "sentence-transformers/distiluse-base-multilingual-cased-v2"
    COLLECTION_NAME = "langchain"
    llm = ChatLlamaCpp(
        model_path=LLM_FILE,
        n_gpu_layers=128,
        n_ctx=CONTEXT_SIZE,
        f16_kv=True,
        verbose=True,
        seed=0
    )
    template = """<s>[INST] <<SYS>>
    あなたは優秀な学生のメンターです。学生の発言に対してメンターとして答えてください。
    <</SYS>>[/INST]
    学生の発言「{input}」"""
    prompt = ChatPromptTemplate.from_template(template)
    output_parser = StrOutputParser()
    chain = {"input": RunnablePassthrough()} | prompt | llm
    response = chain.invoke({"input": message}, config={
        "configurablebb": {"session_id": "abc123"}})["answer"]
    return {
        "message": response
    }
