import 'dart:convert';

import 'package:client/app.dart';
import 'package:client/core/response_extension.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/student/student_repository.dart';
import 'package:openapi/api.dart';

class StudentRepositoryImpl extends StudentRepository {
  /// 学生情報更新API
  @override
  Future<ApiResult<Student>> putStudentInfo(
    String userId,
    StudentUpdate studentUpdate,
    String idToken,
  ) async {
    logger.i("run putStudentInfo()");
    ApiClient apiClient = ApiClient();
    final api = DefaultApi(apiClient);
    try {
      final result = await api.controllerUsersUserIdStudentPutWithHttpInfo(
        userId,
        studentUpdate,
        idToken,
      );
      if (result.isSuccess()) {
        final body = await apiClient.deserializeAsync(
          utf8.decode(result.bodyBytes),
          'Student',
        ) as Student;
        logger.t('status code:${result.statusCode}');
        logger.t("data:${result.body}");
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
