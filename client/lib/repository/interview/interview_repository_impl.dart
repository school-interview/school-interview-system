import 'dart:convert';

import 'package:client/app.dart';
import 'package:client/core/logger.dart';
import 'package:client/core/response_extension.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/interview/interview_repository.dart';
import 'package:openapi/api.dart';

class InterviewRepositoryImpl extends InterviewRepository {
  /// 面談開始リクエスト送信API
  @override
  Future<ApiResult<StartInterviewResponse>> postInterviewSessionRequest(
      InterviewSessionRequest interviewSessionRequest) async {
    logger.enter(message: 'interviewSessionRequest:$interviewSessionRequest');
    ApiClient apiClient = ApiClient();
    final api = DefaultApi(apiClient);
    try {
      final result = await api
          .controllerInterviewPostWithHttpInfo(interviewSessionRequest);
      if (result.isSuccess()) {
        final body = await apiClient.deserializeAsync(
          utf8.decode(result.bodyBytes),
          'StartInterviewResponse',
        ) as StartInterviewResponse;

        logger.exit(message: 'status code:${result.statusCode}');
        return ApiResult(statusCode: result.statusCode, data: body);
      } else {
        logger.exit(message: 'status code:${result.statusCode}');
        return ApiResult(statusCode: result.statusCode);
      }
    } on Exception catch (e) {
      logger.error(message: e.toString());
      logger.exit();
      rethrow;
    }
  }

  @override
  Future<ApiResult<TeacherResponse>> speakToTeacher(String interviewSessionId,
      SpeakToTeacherRequest speakToTeacherRequest) async {
    logger.enter();
    ApiClient apiClient = ApiClient();
    final api = DefaultApi(apiClient);

    try {
      final result =
          await api.controllerInterviewInterviewSessionIdPostWithHttpInfo(
        interviewSessionId,
        speakToTeacherRequest,
      );
      if (result.isSuccess()) {
        final body = await apiClient.deserializeAsync(
          utf8.decode(result.bodyBytes),
          'TeacherResponse',
        ) as TeacherResponse;
        logger.exit(message: 'status code:${result.statusCode}');
        return ApiResult(statusCode: result.statusCode, data: body);
      } else {
        logger.exit(message: 'status code:${result.statusCode}');
        return ApiResult(statusCode: result.statusCode);
      }
    } on Exception catch (e) {
      logger.error(message: e.toString());
      logger.exit();
      rethrow;
    }
  }

  @override
  Future<ApiResult<List<Teacher>>> getTeachers() async {
    logger.enter();
    ApiClient apiClient = ApiClient();
    final api = DefaultApi(apiClient);

    try {
      final result = await api.controllerTeachersGetWithHttpInfo();
      if (result.isSuccess()) {
        final body = await apiClient.deserializeAsync(
          utf8.decode(result.bodyBytes),
          'List<Teacher>',
        ) as List<Teacher>;
        logger.exit(message: 'status code:${result.statusCode}');
        return ApiResult(statusCode: result.statusCode, data: body);
      } else {
        logger.exit(message: 'status code:${result.statusCode}');
        return ApiResult(statusCode: result.statusCode);
      }
    } on Exception catch (e) {
      logger.error(message: e.toString());
      logger.exit();
      rethrow;
    }
  }
}
