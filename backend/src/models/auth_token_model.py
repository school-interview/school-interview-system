from models import BaseModel
from sqlalchemy import String, ForeignKey
from sqlalchemy.orm import mapped_column, Mapped, relationship


class AuthToken(BaseModel):
    __tablename__ = "AuthTokens"
    id: Mapped[int] = mapped_column(primary_key=True)
    token: Mapped[str] = mapped_column(String(36))
    user_id: Mapped[int] = mapped_column(ForeignKey("Users.id"))
    user = relationship("User", backref="auth_tokens")
