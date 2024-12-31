from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
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
from sqlalchemy.orm import Session
from transformers import AutoModelForCausalLM, AutoTokenizer, pipeline
from pydantic import Field
from langchain_huggingface import HuggingFacePipeline
from src.models.limited_chat_message_history import LimitedChatMessageHistory
from src.models.requests.interview_request import InterviewRequest
from logging import getLogger, INFO
from src.utils.format_docs import format_docs
import chromadb
from src.constant import EXAMPLE_OUTPUTS
from fastapi import Response

logger = getLogger(__name__)
logger.setLevel(INFO)

app = FastAPI()

allowed_origins = "*"
app.add_middleware(
    CORSMiddleware,
    allow_origins=allowed_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

vectorstore: Optional[Chroma] = None

chat_history_store = {}

conversation_model_name: str = "elyza/Llama-3-ELYZA-JP-8B"
conversation_tokenizer = AutoTokenizer.from_pretrained(conversation_model_name)
conversation_model = AutoModelForCausalLM.from_pretrained(
    conversation_model_name,
    torch_dtype="auto",
    device_map="cuda",
)

extraction_model_name: str = "Qwen/Qwen2.5-7B-Instruct"
extraction_tokenizer = AutoTokenizer.from_pretrained(extraction_model_name)
extraction_model = AutoModelForCausalLM.from_pretrained(
    extraction_model_name,
    torch_dtype="auto",
    device_map="cuda",
    trust_remote_code=True,
)


@app.post("/interview/{session_id}")
def interview(session_id: str, interview_requset: InterviewRequest):
    logger.info("Received interview request: %s (message: %s)",
                session_id, interview_requset.message_from_student)
    pipe = pipeline("text-generation", model=conversation_model,
                    tokenizer=conversation_tokenizer, max_new_tokens=64)
    global vectorstore
    if vectorstore is None:
        embedding_model = HuggingFaceEmbeddings(
            model_name="intfloat/multilingual-e5-large"
        )
        persit_directory = "./"
        collection_name = "campus_guide_collection"
        persistent_client = chromadb.PersistentClient(path=persit_directory)
        vectorstore = Chroma(
            collection_name,
            client=persistent_client,
            embedding_function=embedding_model
        )
        if len(vectorstore) == 0:
            markdown_path = "campus_guide.md"
            markdown_loader = UnstructuredMarkdownLoader(markdown_path)
            split_texts = list(
                markdown_loader.load_and_split(
                    text_splitter=RecursiveCharacterTextSplitter(
                        chunk_size=200,
                        chunk_overlap=50
                    )
                )
            )
            split_texts = list(
                map(lambda d: d.page_content, split_texts))
            vectorstore.add_texts(split_texts)
    retriever = vectorstore.as_retriever(search_kwargs={"k": 2})

    global chat_history_store

    def get_session_history(session_id: str) -> BaseChatMessageHistory:
        if session_id not in chat_history_store:
            chat_history_store[session_id] = LimitedChatMessageHistory()
        return chat_history_store[session_id]

    llm = HuggingFacePipeline(
        pipeline=pipe
    )
    question_prompt_template_format = conversation_tokenizer.apply_chat_template(
        conversation=[
            {"role": "system", "content": """

            Situation: You are professional Academic Advisor who support school life and carrer. Please respond to the student's question. Always try to resolve a problem the student has. And you are designed to utilize information on school. Please answer based on provided sources.
            You asked the question ( """ + interview_requset.current_question + """) to the student, and the student will answer for your question next.
            You must give a feedback as a professional Academic Advisor to the student. Tell the student your advice or opinion.
            You must answer as if you are speaking directly to the student.
            You must answer in Japanese.
            Our chat history: {history}
            Context: {context}
            """},
            {"role": "user", "content": "{question}"}
        ],
        tokenize=False,
        add_generation_prompt=True
    )
    question_prompt = PromptTemplate(
        template=question_prompt_template_format,  # type: ignore
        input_variables=["question"]
    )

    chain = (
        {
            "context": RunnableLambda(lambda x:
                                      x['question']  # type: ignore
                                      ) | retriever | format_docs,
            "question": RunnableLambda(lambda x: x['question']  # type: ignore
                                       ),
            "history": RunnableLambda(lambda x: x['history'])  # type: ignore
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
        {"question": interview_requset.message_from_student},
        config={
            "configurable": {
                "session_id": session_id
            }
        }
    )
    splits = response.split("\n")
    message = ""
    for s in splits[::-1]:
        if "<|start_header_id|>assistant<|end_header_id|>" in s:
            break
        message += s
    logger.info("Generated response for session '%s': %s", session_id, message)
    return message


@app.get("/extraction/")
def extract_value(extraction_type: str, text: str):
    if not extraction_type:
        raise HTTPException(
            status_code=400, detail="extraction_type is required")
    if not text:
        raise HTTPException(status_code=400, detail="text is required")
    if not (extraction_type in ['int', 'float', 'str', 'bool']):
        raise HTTPException(
            status_code=400, detail="extraction_type must be one of ['int', 'float', 'str', 'bool']")
    pipe = pipeline("text-generation", model=extraction_model,
                    tokenizer=extraction_tokenizer)
    generation_args = {
        "max_new_tokens": 500,
        "return_full_text": False,
        "temperature": 0.0,
        "do_sample": False,
    }
    conversations = [
        {
            "role": "system",
            "content": """
                
                You are a world class algorithm for extracting data and make it to JSON. 
                You must output in JSON format.
            """
            +
            EXAMPLE_OUTPUTS[extraction_type]
        },
        {
            "role": "user",
            "content": text
        }
    ]
    output = pipe(conversations, **generation_args)
    json_output = output[0]['generated_text']  # type: ignore
    return Response(content=json_output, media_type="application/json")
