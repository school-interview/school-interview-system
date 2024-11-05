import 'package:client/repository/api_result.dart';
import 'package:openapi/api.dart';

/// 面談結果管理関連のリポジトリ
abstract class InterviewReportRepository {
  /// 面談結果取得API
  Future<ApiResult<InterviewReportsResponse>> getInterviewReport(
      String idToken);
}
