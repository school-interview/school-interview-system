import 'package:client/repository/api_result.dart';
import 'package:openapi/api.dart';

abstract class InterviewRepository {
  Future<ApiResult<TeacherResponse>> speakToTeacher(
      String interviewSessionId, SpeakToTeacherRequest speakToTeacherRequest);
}
