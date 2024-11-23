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

    /// ユーザーが学生が教員か
    /// true:教員 false:学生
    @Default(false) bool isAdmin,

    /// ユーザー情報
    User? user,
  }) = _LoginState;
}
