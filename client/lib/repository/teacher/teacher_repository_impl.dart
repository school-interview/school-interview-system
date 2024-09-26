import 'dart:convert';

import 'package:client/app.dart';
import 'package:client/core/response_extension.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/teacher/teacher_repository.dart';
import 'package:openapi/api.dart';

class TeacherRepositoryImpl extends TeacherRepository {
  /// 教員リスト取得API
  @override
  Future<ApiResult<List<Teacher>>> getTeachersList() async {
    logger.i("run getTeacher()");
    ApiClient apiClient = ApiClient();
    final api = DefaultApi(apiClient);
    try {
      final result = await api.controllerTeachersGetWithHttpInfo();
      if (result.isSuccess()) {
        final body = await apiClient.deserializeAsync(
          utf8.decode(result.bodyBytes),
          'List<Teacher>',
        ) as List<Teacher>;
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
