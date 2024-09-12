from uuid import UUID
from src.models.db_models.user_model import User
from src.models import EntityBaseModel
from sqlalchemy import String, ForeignKey
from typing import List, Optional
from sqlalchemy.orm import mapped_column, Mapped, relationship
from pydantic import BaseModel


class WebsocketConnection(BaseModel):
    id: UUID
    socket_id: str
    user_id: UUID
    user: Optional[User]


class WebsocketConnectionModel(EntityBaseModel):
    __tablename__ = "WebsocketConnections"
    id: Mapped[UUID] = mapped_column(primary_key=True)
    socket_id: Mapped[str] = mapped_column(String(100))
    user_id: Mapped[UUID] = mapped_column(ForeignKey("Users.id"))
    user = relationship("UserModel", backref="connections")
