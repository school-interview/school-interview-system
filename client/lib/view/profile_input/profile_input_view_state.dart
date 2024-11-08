import 'package:client/constant/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_input_view_state.freezed.dart';

@freezed
abstract class ProfileInputViewState with _$ProfileInputViewState {
  /// 情報入力画面の状態を表すクラス
  const factory ProfileInputViewState({
    /// API処理結果
    Result? result,

    /// 学籍番号
    @Default("") String studentId,

    /// 氏名
    @Default("") String name,

    /// 学科
    @Default("") String department,

    /// 学期（前学期か後学期）
    @Default(1) int semester,
  }) = _ProfileInputViewState;
}
