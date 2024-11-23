from typing import Optional
from langchain_core.pydantic_v1 import BaseModel, Field


class IntExtraction(BaseModel):
    extracted_value: Optional[int] = Field(
        description="Extracted integer value")
