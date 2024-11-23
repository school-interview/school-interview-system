import 'dart:convert';

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
  setResult(Result? result) => state = state.copyWith(result: result);

  _setIsAdmin(bool isAdmin) => state = state.copyWith(isAdmin: isAdmin);

  _setUser(User? user) => state = state.copyWith(user: user);

  /// ログインリポジトリ
  final LoginRepository _loginRepository = LoginRepositoryImpl();

  /// 永続化マネージャー
  final SharedPreferenceManager _sharedPreferenceManager =
      SharedPreferenceManager();

  /// ユーザー情報取得API
  Future<void> getUserInfo() async {
    logger.i("run getUserInfo()");
    try {
      final idToken =
          await _sharedPreferenceManager.getString(PrefKeys.idToken);
      ApiResult<User> response =
          await _loginRepository.getUserInfo(idToken ?? "");
      switch (response.statusCode) {
        case 200:
          _setIsAdmin(response.data!.isAdmin);
          _setUser(response.data!);
          setResult(Result.success);
          break;
        default:
          setResult(Result.fail);
          break;
      }
      logger.t("responseData:${response.data}");
    } on Exception catch (e) {
      logger.e(e.toString());
      return;
    }
  }

  /// ログイン時の処理
  Future<void> login(dynamic data) async {
    logger.i("run login()");
    Map<String, dynamic> mapLoginResult = json.decode(data);
    final result = LoginResult.fromJson(mapLoginResult);
    await _sharedPreferenceManager.setString(PrefKeys.idToken, result?.idToken);
    await _sharedPreferenceManager.setString(
        PrefKeys.refreshToken, result?.refreshToken);
    await _sharedPreferenceManager.setString(PrefKeys.userId, result?.user.id);
    await getUserInfo();
  }
}
