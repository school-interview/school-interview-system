from langchain_community.chat_message_histories import ChatMessageHistory
from pydantic import Field
from typing import Any, Dict, List, Optional, Union, Sequence
from langchain_core.messages import BaseMessage


class LimitedChatMessageHistory(ChatMessageHistory):
    max_messages: int = Field(default=2)

    def __init__(self, max_messages=2):
        super().__init__()
        self.max_messages = max_messages

    def add_messages(self, messages: Sequence[BaseMessage]) -> None:
        super().add_messages(messages)
        self._limit_messages()

    def _limit_messages(self):
        if len(self.messages) > self.max_messages:
            self.messages = self.messages[-self.max_messages:]
