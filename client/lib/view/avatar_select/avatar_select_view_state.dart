import 'package:client/constant/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:openapi/api.dart';

part 'avatar_select_view_state.freezed.dart';

@freezed
abstract class AvatarSelectViewState with _$AvatarSelectViewState {
  /// アバター選択画面の状態を表すクラス
  const factory AvatarSelectViewState({
    /// API処理結果
    Result? result,

    /// 教員リストレスポンス
    TeachersListResponse? teacherListResponse,

    /// 選択した教員ID
    @Default("") String selectedTeacherId,
  }) = _AvatarSelectViewState;
}
