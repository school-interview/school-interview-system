from langchain_core.pydantic_v1 import BaseModel, Field
from typing import Optional


class SchoolCredit(BaseModel):
    credit: Optional[int] = Field(description="単位数（大学）")
