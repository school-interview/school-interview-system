from uuid import UUID
from src.models import EntityBaseModel
from sqlalchemy import String, ForeignKey
from typing import List
from sqlalchemy.orm import mapped_column, Mapped, relationship


class WebsocketConnection(EntityBaseModel):
    __tablename__ = "WebsocketConnections"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    socket_id: Mapped[str] = mapped_column(String(100))
    user_id: Mapped[UUID] = mapped_column(ForeignKey("Users.id"))
    user = relationship("User", backref="connections")
