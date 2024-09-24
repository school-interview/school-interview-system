import 'package:client/repository/api_result.dart';
import 'package:openapi/api.dart';

/// ユーザー情報を登録するためのリポジトリ
abstract class LoginRepository {
  /// ユーザー情報登録API
  Future<ApiResult<User>> putUserInformation(LoginRequest loginRequest);
}