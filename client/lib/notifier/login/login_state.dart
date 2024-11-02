import 'package:client/constant/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:openapi/api.dart';

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

    /// ユーザーデータ
    User? user,
  }) = _LoginState;
}
