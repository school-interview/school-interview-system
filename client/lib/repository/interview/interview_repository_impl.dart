import 'dart:convert';

import 'package:client/app.dart';
import 'package:client/core/logger.dart';
import 'package:client/core/response_extension.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/interview/interview_repository.dart';
import 'package:openapi/api.dart';

class InterviewRepositoryImpl extends InterviewRepository {
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
}
