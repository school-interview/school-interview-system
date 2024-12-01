from typing import Optional
from langchain_core.pydantic_v1 import BaseModel, Field


class BoolExtraction(BaseModel):
    extracted_value: Optional[bool] = Field(
        description="Extracted boolean value")
