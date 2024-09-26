from langchain_core.pydantic_v1 import BaseModel, Field
from typing import Optional


class AttendanceRate(BaseModel):
    attendance_rate: Optional[float] = Field(description="出席率")
