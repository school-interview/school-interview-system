import 'package:freezed_annotation/freezed_annotation.dart';

part 'interview_analytics_view_state.freezed.dart';

@freezed
abstract class InterviewAnalyticsViewState with _$InterviewAnalyticsViewState {
  /// インタビュー画面の状態を表すクラス
  const factory InterviewAnalyticsViewState({
    /// アニメーションが動いたかどうかを判別する
    @Default(false) bool isAnimated,
  }) = _InterviewAnalyticsViewState;
}
