import 'dart:convert';

import 'package:client/app.dart';
import 'package:client/core/response_extension.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/login/login_repository.dart';
import 'package:openapi/api.dart';
import 'package:client/core/logger.dart';

/// ユーザー情報を登録するためのリポジトリ
class LoginRepositoryImpl extends LoginRepository {
  /// ユーザー情報登録API
  @override
  Future<ApiResult<User>> putUserInformation(LoginRequest loginRequest) async {
    logger.enter(message: 'loginRequest:$loginRequest');
    ApiClient apiClient = ApiClient();
    final api = DefaultApi(apiClient);
    try {
      final result =
      await api.controllerLoginPutWithHttpInfo(loginRequest);
      if (result.isSuccess()) {
        final body = await apiClient.deserializeAsync(
          utf8.decode(result.bodyBytes),
          'User',
        ) as User;
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