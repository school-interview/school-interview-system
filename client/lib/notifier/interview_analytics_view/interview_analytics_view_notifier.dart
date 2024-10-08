import 'package:client/view/interview_analytics/interview_analytics_view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interview_analytics_view_notifier.g.dart';

@riverpod
class InterviewAnalyticsViewNotifier extends _$InterviewAnalyticsViewNotifier {
  @override
  InterviewAnalyticsViewState build() {
    return const InterviewAnalyticsViewState();
  }

  void setIsAnimated(bool isAnimated) =>
      state = state.copyWith(isAnimated: isAnimated);

  /// 要支援レベルの内訳の値を生成する
  String getElementValue(num? factor, double parameter) {
    final value = ((factor?.toDouble() ?? 0) * parameter).toStringAsFixed(1);
    return value;
  }

  /// 円グラフにセットするデータマップを作成する
  Map<String, double> createChartDataMap(
      List<double> values, bool isFullScore) {
    Map<String, double> dataMap = {};
    if (isFullScore) {
      dataMap.addAll({"1": 100});
      return dataMap;
    } else {
      for (int i = 0; i < values.length; i++) {
        dataMap.addAll({"${i + 1}": values[i]});
      }
      return dataMap;
    }
  }
}
