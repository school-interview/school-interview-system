from uuid import UUID
from src.models import BaseModel
from sqlalchemy import String, ForeignKey
from typing import List
from sqlalchemy.orm import mapped_column, Mapped, relationship


class Connection(BaseModel):
    __tablename__ = "Connections"
    __table_args__ = {'extend_existing': True}
    id: Mapped[UUID] = mapped_column(primary_key=True)
    socket_id: Mapped[str] = mapped_column(String(100))
    user_id: Mapped[UUID] = mapped_column(ForeignKey("Users.id"))
    user = relationship("User", backref="connections")
