import 'dart:convert';

import 'package:client/app.dart';
import 'package:client/core/response_extension.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/login/login_repository.dart';
import 'package:openapi/api.dart';

class LoginRepositoryImpl extends LoginRepository {
  /// ユーザー情報登録API
  @override
  Future<ApiResult<User>> putUserInfo(LoginRequest loginRequest) async {
    logger.i('loginRequest:$loginRequest');
    ApiClient apiClient = ApiClient();
    final api = DefaultApi(apiClient);
    try {
      final result = await api.controllerLoginPutWithHttpInfo(loginRequest);
      if (result.isSuccess()) {
        final body = await apiClient.deserializeAsync(
          utf8.decode(result.bodyBytes),
          'User',
        ) as User;
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
