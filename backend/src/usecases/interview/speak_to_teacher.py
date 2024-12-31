
import os
import re
from typing import Any, Dict, List, Optional, Union, Sequence
from uuid import UUID
import httpx
from langchain_community.chat_message_histories import ChatMessageHistory
from langchain_core.chat_history import BaseChatMessageHistory
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder, HumanMessagePromptTemplate
from langchain_core.runnables.history import RunnableWithMessageHistory
from huggingface_hub import hf_hub_download
from langchain_community.chat_models import ChatLlamaCpp
from langchain_community.vectorstores import Chroma
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate, PromptTemplate
from langchain_core.runnables import RunnablePassthrough, RunnableLambda
from langchain_huggingface import HuggingFaceEmbeddings
from langchain import hub
from langchain_openai import ChatOpenAI
from langchain.schema import HumanMessage, SystemMessage
from langchain_core.tracers.stdout import ConsoleCallbackHandler
from langchain_community.document_loaders import UnstructuredMarkdownLoader
from langchain_core.messages import BaseMessage
from pydantic import TypeAdapter
from src.models import InterviewSessionModel, InterviewRecordModel, TeacherResponse, InterviewQuestionModel, InterviewQuestion, InterviewQuestionGroupModel, ExtractionResult, TeacherModel, IntExtraction, BoolExtraction, FloatExtraction, StrExtraction, LlmServiceInterviewRequest
from sqlalchemy.orm import Session
from src.usecases.interview.finish_interview import finish_interview
from src.crud import InterviewQuestionGroupsCrud, InterviewQuestionsCrud, InterviewRecordsCrud
from transformers import AutoModelForCausalLM, AutoTokenizer, pipeline
from pydantic import Field
from langchain_huggingface import HuggingFacePipeline

OPENAI_API_KEY = os.getenv('OPENAI_API_KEY')
LLM_SERVICE_ENDPOINT = os.getenv("LLM_SERVICE_ENDPOINT")

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
    current_question = questions_dict[interview_session.current_question_id]
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
            finish_interview(db_session, interview_session)
            # TODO: この返答雑すぎるので、もう少し工夫する。（ここもLLM使って生成したい）
            return "面談はこれで終了です。ありがとうございました。"
        db_session.commit()
    next_question = questions_dict[interview_session.current_question_id]
    message_from_teacher = generate_message_from_teacher(
        interview_session,  message_from_user, current_question, next_question)
    return message_from_teacher


def generate_message_from_teacher(
        interview_session: InterviewSessionModel,
        message_from_student: str,
        current_question: InterviewQuestion,
        next_question: InterviewQuestion
):
    if LLM_SERVICE_ENDPOINT is None:
        raise Exception(
            "could not load LLM_SERVICE_ENDPOINT. It's likely because .env.local file doesn't exist.")
    url = LLM_SERVICE_ENDPOINT + "interview/" + str(interview_session.id)
    request_body = LlmServiceInterviewRequest(
        message_from_student=message_from_student,
        current_question=current_question.question
    )
    with httpx.Client() as client:
        response = client.post(url, json=request_body.__dict__)
    if response and response.status_code != 200:
        raise Exception(
            "Failed to generate message from teacher. Status code: " + str(response.status_code))
    message = response.json() + next_question.question
    return message


def extract_value(

    interview_session: InterviewSessionModel,
    message_from_student: str,
    questions_dict: Dict[UUID, InterviewQuestion]
):
    current_question = questions_dict[interview_session.current_question_id]
    if LLM_SERVICE_ENDPOINT is None:
        raise Exception(
            "could not load LLM_SERVICE_ENDPOINT. It's likely because .env.local file doesn't exist.")
    url = LLM_SERVICE_ENDPOINT + \
        f"extraction?extraction_type={current_question.extraction_data_type}&text={message_from_student}"

    with httpx.Client() as client:
        response = client.get(url)
        if response and response.status_code != 200:
            raise Exception(
                "Failed to generate message from teacher. Status code: " + str(response.status_code))
    extracted_value = response.json()['extracted_value']

    match current_question.extraction_data_type:
        case 'bool':
            extracted_value = True if extracted_value.lower() == 'true' else False
        case 'int':
            extracted_value = int(extracted_value)
        case 'float':
            extracted_value = float(extracted_value)

    return ExtractionResult(
        question_id_before_update=current_question.id,
        interview_session=interview_session,
        succeeded_to_extract=False if extracted_value is None else True,
        extracted_value=extracted_value
    )
