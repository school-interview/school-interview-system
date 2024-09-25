import 'package:client/constant/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:openapi/api.dart';

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

    /// 面談開始レスポンス
    StartInterviewResponse? startInterviewResponse,

    /// 最新のinterivewSession
    InterviewSession? currentInterviewSession,
    @Default([]) List<Teacher> teachers,

    /// API処理結果
    Result? result,
  }) = _InterviewViewState;
}
