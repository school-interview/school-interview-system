from langchain_core.pydantic_v1 import BaseModel, Field
from typing import Optional


class SchoolCredit(BaseModel):
    credit: Optional[int] = Field(description="単位数（大学）")


class Gpa(BaseModel):
    gpa: Optional[float] = Field(description="GPA")


class AttendanceRate(BaseModel):
    attendance_rate: Optional[float] = Field(description="出席率")


class Trouble(BaseModel):
    trouble: Optional[str] = Field(description="困りごと")


class PreferInPerson(BaseModel):
    prefer_in_person: Optional[bool] = Field(description="対面の面談を希望するか")
