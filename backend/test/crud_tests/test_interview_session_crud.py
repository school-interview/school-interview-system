import uuid
from mock_alchemy.mocking import UnifiedAlchemyMagicMock
from sqlalchemy import create_engine
from src.models import EntityBaseModel, InterviewSessionModel
from src.crud import InterviewSessionsCrud
engine = create_engine('sqlite:///:memory:', echo=True)
session = UnifiedAlchemyMagicMock()
engine.connect()
EntityBaseModel.metadata.create_all(engine)
