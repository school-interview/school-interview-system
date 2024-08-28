from models import BaseModel
from sqlalchemy import String, ForeignKey
from typing import List
from sqlalchemy.orm import mapped_column, Mapped, relationship


class Connection(BaseModel):
    __tablename__ = "Connections"
    id: Mapped[str] = mapped_column(primary_key=True)
    socket_id: Mapped[str] = mapped_column(String(100))
    user_id = mapped_column(ForeignKey("Users.id"))
    user = relationship("User", backref="connections")
