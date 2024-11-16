from typing import Dict, Set, Type, TypeVar
from pydantic import BaseModel, ConfigDict, TypeAdapter
from sqlalchemy.orm import DeclarativeBase
from pydantic.alias_generators import to_camel

T = TypeVar('T')

primitives = (bool, str, int, float, type(None))


class EntityBaseModel(DeclarativeBase):
    def convertToPydantic(self, cls: Type[T], obj_history: Set, model_class_mapping: Dict[str, BaseModel] = None) -> Type[T]:
        """
        SQLAlchemyモデルをPydanticモデルに変換するメソッドです。
            Args:
                cls (Type[T]): Pydanticモデルのクラス
                obj_history (Set): 循環参照チェック用のセット
                model_class_mapping (Dict[str, BaseModel], optional): ネストされたモデルのクラスマッピング。デフォルトはNone。
        """
        dict_to_convert = self.__dict__
        obj_history.add(id(self))  # 循環参照チェック用
        keys = dict_to_convert.keys()
        for key in keys:
            value = dict_to_convert[key]
            # 以前に登場したオブジェクトはNone。（循環参照を防ぐため）
            if (type(value) not in primitives) and (id(value) in obj_history):
                dict_to_convert[key] = None
            elif issubclass(value.__class__, DeclarativeBase):
                model: EntityBaseModel = dict_to_convert[key]
                if model_class_mapping is None:
                    raise ValueError(
                        "model_class_mapping is required for nested models")
                model_class = model_class_mapping[model.__class__.__name__]
                pydantic_model: BaseModel = model.convertToPydantic(
                    model_class, model_class_mapping=model_class_mapping, obj_history=obj_history)
                dict_to_convert[key] = pydantic_model.__dict__
            obj_history.add(id(value))
        return TypeAdapter(cls).validate_python(dict_to_convert)

    def convert_to_dict(self):
        d = {}
        for column in self.__table__.columns:
            d[column.name] = getattr(self, column.name)
        return d
