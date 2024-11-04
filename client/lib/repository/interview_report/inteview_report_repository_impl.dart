import 'dart:convert';

import 'package:client/app.dart';
import 'package:client/core/response_extension.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/interview_report/interview_report_repository.dart';
import 'package:openapi/api.dart';

class InterviewReportRepositoryImpl extends InterviewReportRepository {
  /// 面談結果取得API
  @override
  Future<ApiResult<InterviewReportsResponse>> getInterviewReport() async {
    logger.i("run getInterviewReport()");
    ApiClient apiClient = ApiClient();
    final api = DefaultApi(apiClient);
    try {
      final result = await api.controllerInterviewReportsGetWithHttpInfo();
      if (result.isSuccess()) {
        final body = await apiClient.deserializeAsync(
          utf8.decode(result.bodyBytes),
          'InterviewReportsResponse',
        ) as InterviewReportsResponse;
        logger.t('status code:${result.statusCode}');
        return ApiResult(statusCode: result.statusCode, data: body);
      } else {
        logger.t('status code:${result.statusCode}');
        return ApiResult(statusCode: result.statusCode);
      }
    } on Exception catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }
}
