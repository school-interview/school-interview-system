import 'package:client/repository/api_result.dart';
import 'package:openapi/api.dart';

/// ログイン関連のリポジトリ
abstract class LoginRepository {
  /// ユーザー情報取得API
  Future<ApiResult<User>> getUserInfo(String idToken);
}
