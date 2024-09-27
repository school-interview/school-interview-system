from langchain_core.pydantic_v1 import BaseModel, Field
from typing import Optional


class Gpa(BaseModel):
    gpa: Optional[float] = Field(description="GPA")
