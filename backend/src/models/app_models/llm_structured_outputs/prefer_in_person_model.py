from langchain_core.pydantic_v1 import BaseModel, Field
from typing import Optional


class PreferInPerson(BaseModel):
    prefer_in_person: Optional[bool] = Field(description="対面の面談を希望するか")
