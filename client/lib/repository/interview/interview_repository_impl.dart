import 'dart:convert';

import 'package:client/app.dart';
import 'package:client/core/response_extension.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/interview/interview_repository.dart';
import 'package:openapi/api.dart';

class InterviewRepositoryImpl extends InterviewRepository {
  /// 面談開始リクエスト送信API
  @override
  Future<ApiResult<StartInterviewResponse>> postInterviewSessionRequest(
      InterviewSessionRequest interviewSessionRequest, String idToken) async {
    logger.i("run postInterviewSessionRequest()");
    logger.t('interviewSessionRequest:$interviewSessionRequest');
    ApiClient apiClient = ApiClient();
    final api = DefaultApi(apiClient);
    try {
      final result = await api.controllerInterviewPostWithHttpInfo(
          interviewSessionRequest, idToken);
      if (result.isSuccess()) {
        final body = await apiClient.deserializeAsync(
          utf8.decode(result.bodyBytes),
          'StartInterviewResponse',
        ) as StartInterviewResponse;
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

  /// 教員メッセージ受信API
  @override
  Future<ApiResult<TeacherResponse>> getMessageFromTeacher(
    String interviewSessionId,
    SpeakToTeacherRequest speakToTeacherRequest,
    String idToken,
  ) async {
    logger.i("run getMessageFromTeacher()");
    logger.t(
        "interviewSessionId:$interviewSessionId, speakToTeacherRequest:$speakToTeacherRequest");
    ApiClient apiClient = ApiClient();
    final api = DefaultApi(apiClient);
    try {
      final result =
          await api.controllerInterviewInterviewSessionIdPostWithHttpInfo(
        interviewSessionId,
        speakToTeacherRequest,
        idToken,
      );
      if (result.isSuccess()) {
        final body = await apiClient.deserializeAsync(
          utf8.decode(result.bodyBytes),
          'TeacherResponse',
        ) as TeacherResponse;
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

  /// 要支援レベル取得API
  @override
  Future<ApiResult<InterviewAnalytics>> getInterviewAnalytics(
    String interviewSessionId,
    String idToken,
  ) async {
    logger.i("run getInterviewAnalytics()");
    ApiClient apiClient = ApiClient();
    final api = DefaultApi(apiClient);
    try {
      final result = await api
          .controllerInterviewInterviewSessionIdAnalyticsGetWithHttpInfo(
              interviewSessionId, idToken);
      if (result.isSuccess()) {
        final body = await apiClient.deserializeAsync(
          utf8.decode(result.bodyBytes),
          'InterviewAnalytics',
        ) as InterviewAnalytics;
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
