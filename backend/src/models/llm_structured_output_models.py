from langchain_core.pydantic_v1 import BaseModel, Field


class SchoolCredit(BaseModel):
    credit: int = Field(description="単位数（大学）")


class Gpa(BaseModel):
    gpa: float = Field(description="GPA")


class AttendanceRate(BaseModel):
    attendance_rate: float = Field(description="出席率")


class Trouble(BaseModel):
    trouble: str = Field(description="困りごと")


class PreferInPerson(BaseModel):
    prefer_in_person: bool = Field(description="対面の面談を希望するか")
