from typing import Optional
from langchain_core.pydantic_v1 import BaseModel, Field


class FloatExtraction(BaseModel):
    extracted_value: Optional[float] = Field(
        description="Extracted float value")
