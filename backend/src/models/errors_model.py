from abc import ABCMeta
from typing import Any


class AppException(Exception, metaclass=ABCMeta):
    def __init__(self, arg: Any):
        self.arg = arg


class InterviewAlreadyStartedException(AppException):
    pass
