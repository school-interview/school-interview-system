from langchain_core.pydantic_v1 import BaseModel, Field
from typing import Optional


class Concern(BaseModel):
    trouble: Optional[str] = Field(description="困りごと")
