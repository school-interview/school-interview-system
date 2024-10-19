from typing import Type, TypeVar
from pydantic import BaseModel, ConfigDict, TypeAdapter
from sqlalchemy.orm import DeclarativeBase
from pydantic.alias_generators import to_camel

T = TypeVar('T')


class EntityBaseModel(DeclarativeBase):
    def convertToPydantic(self, cls: Type[T]) -> Type[T]:
        return TypeAdapter(cls).validate_python(self.__dict__)
