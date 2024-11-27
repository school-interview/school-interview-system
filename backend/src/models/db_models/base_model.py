from typing import Any, Dict, Optional, Set, Type, TypeVar
from pydantic import BaseModel, ConfigDict, TypeAdapter
from sqlalchemy.orm import DeclarativeBase
from pydantic.alias_generators import to_camel

T = TypeVar('T', bound=BaseModel)

primitives = (bool, str, int, float, type(None))


class EntityBaseModel(DeclarativeBase):
    def convert_to_pydantic(
            self,
            cls: Type[T],
            obj_history: Set,
            model_class_mapping: Optional[Dict] = None
    ) -> T:
        """
        SQLAlchemyモデルをPydanticモデルに変換するメソッドです。
            Args:
                cls (Type[T]): Pydanticモデルのクラス
                obj_history (Set): 循環参照チェック用のセット
                model_class_mapping (Dict[str, BaseModel], optional): ネストされたモデルのクラスマッピング。デフォルトはNone。
        """
        dict_to_convert: Dict[str, Any] = self.convert_to_dict()
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
                model_class: Type[T] = model_class_mapping[model.__class__.__name__]
                pydantic_model = model.convert_to_pydantic(
                    model_class, obj_history=obj_history, model_class_mapping=model_class_mapping)
                # dict_to_convert[key] = pydantic_model.convert_to_dict()
                dict_to_convert[key] = pydantic_model
            obj_history.add(id(value))
        return (
            TypeAdapter(cls)
            .validate_python(dict_to_convert)  # type: ignore
        )

    def convert_to_dict(self) -> Dict[str, Any]:
        d = {}
        for column in self.__table__.columns:
            d[column.name] = getattr(self, column.name)
        return d
