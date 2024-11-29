import 'package:client/constant/enum/who_talking.dart';
import 'package:client/constant/result.dart';
import 'package:client/model/chat_history.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:openapi/api.dart';

part 'interview_view_state.freezed.dart';

@freezed
abstract class InterviewViewState with _$InterviewViewState {
  /// インタビュー画面の状態を表すクラス
  const factory InterviewViewState({
    /// API処理結果
    Result? result,

    /// ローディング中かどうかを判別する
    @Default(false) bool isLoading,

    /// チャットの履歴
    @Default([]) List<ChatHistory> chatHistories,

    /// アバターのセリフ
    @Default("こんにちは。これから面談を始めます。") String avatarMessage,

    /// ユーザーのセリフ
    @Default("") String userMessage,

    /// 誰が話しているかを判別する
    @Default(WhoTalking.avatar) WhoTalking whoTalking,

    /// 最新のinterviewSessionId
    @Default("") String currentInterviewSessionId,

    /// 面談結果
    InterviewAnalytics? interviewAnalytics,

    /// 面談が終了したかどうかを判別する
    @Default(false) bool isFinishInterview,
  }) = _InterviewViewState;
}
