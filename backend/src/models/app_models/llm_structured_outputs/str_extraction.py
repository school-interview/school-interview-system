from typing import Optional
from langchain_core.pydantic_v1 import BaseModel, Field


class StrExtraction(BaseModel):
    extracted_value: Optional[str] = Field(
        description="Extracted string value")
