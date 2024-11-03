import 'package:client/constant/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  /// ログインの状態を保持する
  const factory LoginState({
    /// API処理結果
    Result? result,

    /// IDトークン
    @Default("") String idToken,

    /// リフレッシュトークン
    @Default("") String refreshToken,

    /// ユーザーが学生が教員か
    /// true:教員 false:学生
    @Default(false) bool isAdmin,
  }) = _LoginState;
}
