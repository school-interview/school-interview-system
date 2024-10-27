from typing import Dict, Type, TypeVar
from pydantic import BaseModel, ConfigDict, TypeAdapter
from sqlalchemy.orm import DeclarativeBase
from pydantic.alias_generators import to_camel

T = TypeVar('T')

primitives = (bool, str, int, float, type(None))


class EntityBaseModel(DeclarativeBase):
    def convertToPydantic(self, cls: Type[T], model_class_mapping: Dict[DeclarativeBase, BaseModel] = None, _obj_history=set()) -> Type[T]:
        dict_to_convert = self.__dict__
        _obj_history.add(id(self))  # 循環参照チェック用
        keys = dict_to_convert.keys()
        for key in keys:
            value = dict_to_convert[key]
            # 以前に登場したオブジェクトはNone。（循環参照を防ぐため）
            if (type(value) not in primitives) and (id(value) in _obj_history):
                dict_to_convert[key] = None
            elif issubclass(value.__class__, DeclarativeBase):
                model: EntityBaseModel = dict_to_convert[key]
                if model_class_mapping is None:
                    raise ValueError(
                        "model_class_mapping is required for nested models")
                model_class = model_class_mapping[model.__class__.__name__]
                pydantic_model: BaseModel = model.convertToPydantic(
                    model_class, model_class_mapping, _obj_history)
                dict_to_convert[key] = pydantic_model.__dict__
            _obj_history.add(id(value))
        _obj_history.clear()
        return TypeAdapter(cls).validate_python(dict_to_convert)
