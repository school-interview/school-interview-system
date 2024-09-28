import 'package:client/constant/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'interview_view_state.freezed.dart';

@freezed
abstract class InterviewViewState with _$InterviewViewState {
  /// インタビュー画面の状態を表すクラス
  const factory InterviewViewState({
    /// API処理結果
    Result? result,

    /// ローディング中かどうかを判別する
    @Default(true) bool isLoading,

    /// アバターのセリフ
    @Default("") String avatarMessage,

    /// ユーザーのセリフ
    @Default("") String userMessage,

    /// ユーザーが話しているかどうかを判別する
    @Default(false) bool isTalking,

    /// 最新のinterviewSessionId
    @Default("") String currentInterviewSessionId,
  }) = _InterviewViewState;
}
