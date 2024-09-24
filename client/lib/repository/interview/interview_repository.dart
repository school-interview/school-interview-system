import 'package:client/repository/api_result.dart';
import 'package:openapi/api.dart';

/// 面談関連のリポジトリ
abstract class InterviewRepository {
  /// 面談開始リクエスト送信API
  Future<ApiResult<StartInterviewResponse>> postInterviewSessionRequest(
      InterviewSessionRequest interviewSessionRequest);
  Future<ApiResult<TeacherResponse>> speakToTeacher(
      String interviewSessionId, SpeakToTeacherRequest speakToTeacherRequest);
}
