import 'package:freezed_annotation/freezed_annotation.dart';

part 'interview_view_state.freezed.dart';

@freezed
abstract class InterviewViewState with _$InterviewViewState {
  /// インタビュー画面の状態を表すクラス
  const factory InterviewViewState({
    /// アバターのセリフ
    @Default("") String avatarSpeech,

    /// ユーザーのセリフ
    @Default("") String userSpeech,

    /// ユーザーが話しているかどうかを判別する
    @Default(false) bool isTalking,
  }) = _InterviewViewState;
}
