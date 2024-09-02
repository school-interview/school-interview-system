from typing import List
from src.models import RestApiController


class StartInterviewSessionRestApiController(RestApiController):
    method = "POST"
    path = "/interview"

    async def controller(self, data):

        pass


class SpeakToTeacherRestApiController(RestApiController):
    method = "POST"
    path = "/interview/{interview_session_id}"

    async def controller(self, data):
        pass


class FinishInterviewSessionRestApiController(RestApiController):
    method = "DELETE"
    path = "/interview/{interview_session_id}"

    async def controller(self, data):
        pass


interview_rest_api_controllers: List[RestApiController] = [StartInterviewSessionRestApiController(
), SpeakToTeacherRestApiController(), FinishInterviewSessionRestApiController()]
