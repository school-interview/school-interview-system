import 'package:client/constant/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_input_view_state.freezed.dart';

@freezed
abstract class ProfileInputViewState with _$ProfileInputViewState {
  /// プロフィール入力画面の状態を表すクラス
  const factory ProfileInputViewState({
    /// API処理結果
    Result? result,
  }) = _ProfileInputViewState;
}
