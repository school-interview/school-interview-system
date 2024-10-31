import 'dart:convert';

import 'package:client/app.dart';
import 'package:client/core/response_extension.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/login/login_repository.dart';
import 'package:openapi/api.dart';

class LoginRepositoryImpl extends LoginRepository {
  /// ログイントークン取得API
  @override
  Future<ApiResult<LoginResult>> getLoginToken() async {
    logger.i("run getLoginToken()");
    ApiClient apiClient = ApiClient();
    final api = DefaultApi(apiClient);
    try {
      final result = await api.controllerLoginGetWithHttpInfo();
      if (result.isSuccess()) {
        final body = await apiClient.deserializeAsync(
          utf8.decode(result.bodyBytes),
          'LoginResult',
        ) as LoginResult;
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
