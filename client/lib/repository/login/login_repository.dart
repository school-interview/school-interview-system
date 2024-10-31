import 'package:client/repository/api_result.dart';
import 'package:openapi/api.dart';

/// ログイン関連のリポジトリ
abstract class LoginRepository {
  /// ログイントークン取得API
  Future<ApiResult<LoginResult>> getLoginToken();
}
