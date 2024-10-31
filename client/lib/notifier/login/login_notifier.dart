import 'package:client/app.dart';
import 'package:client/constant/result.dart';
import 'package:client/infrastructure/shared_preference_manager.dart';
import 'package:client/notifier/login/login_state.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/login/login_repository.dart';
import 'package:client/repository/login/login_repository_impl.dart';
import 'package:openapi/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_notifier.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() {
    return const LoginState();
  }

  /// 以下、setter
  _setResult(Result result) => state.copyWith(result: result);

  _setIdToken(String idToken) => state.copyWith(idToken: idToken);

  _setRefreshToken(String refreshToken) =>
      state.copyWith(refreshToken: refreshToken);

  _setUser(User user) => state.copyWith(user: user);

  /// ログインリポジトリ
  final LoginRepository _loginRepository = LoginRepositoryImpl();

  /// 永続化マネージャー
  final SharedPreferenceManager _sharedPreferenceManager =
      SharedPreferenceManager();

  /// ログイン時の処理
  Future<void> getLoginToken() async {
    try {
      ApiResult<LoginResult> response = await _loginRepository.getLoginToken();
      switch (response.statusCode) {
        case 200:
          _setResult(Result.success);
          _setIdToken(response.data!.idToken);
          _setRefreshToken(response.data!.refreshToken);
          _setUser(response.data!.user);
          _setToken(idToken: state.idToken, refreshToken: state.refreshToken);
          break;
        default:
          _setResult(Result.fail);
          break;
      }
      logger.t("responseData:${response.data}");
    } on Exception catch (e) {
      logger.e(e.toString());
      return;
    }
  }

  /// トークンを保存する
  Future<void> _setToken({
    required String idToken,
    required String refreshToken,
  }) async {
    await _sharedPreferenceManager.setString(PrefKeys.idToken, idToken);
    await _sharedPreferenceManager.setString(
        PrefKeys.refreshToken, refreshToken);
  }
}
