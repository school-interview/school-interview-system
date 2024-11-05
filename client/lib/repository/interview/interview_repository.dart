import 'package:client/repository/api_result.dart';
import 'package:openapi/api.dart';

/// 面談関連のリポジトリ
abstract class InterviewRepository {
  /// 面談開始リクエスト送信API
  Future<ApiResult<StartInterviewResponse>> postInterviewSessionRequest(
      InterviewSessionRequest interviewSessionRequest, String idToken);

  /// 教員メッセージ取得API
  Future<ApiResult<TeacherResponse>> getMessageFromTeacher(
    String interviewSessionId,
    SpeakToTeacherRequest speakToTeacherRequest,
    String idToken,
  );

  /// 要支援レベル取得API
  Future<ApiResult<InterviewAnalytics>> getInterviewAnalytics(
      String interviewSessionId, String idToken);
}
