import 'package:client/view/interview_analytics/interview_analytics_view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interview_analytics_view_notifier.g.dart';

@riverpod
class InterviewAnalyticsViewNotifier extends _$InterviewAnalyticsViewNotifier {
  @override
  InterviewAnalyticsViewState build() {
    return const InterviewAnalyticsViewState();
  }

  void setIsAnimated(bool isAnimated) => state = state.copyWith(isAnimated: isAnimated);
}
