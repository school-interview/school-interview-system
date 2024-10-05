import 'dart:core';

import 'package:client/constant/color.dart';
import 'package:client/constant/enum/support_necessity_level_element.dart';
import 'package:client/constant/support_necessity_level.dart';
import 'package:client/notifier/interview_analytics_view/interview_analytics_view_notifier.dart';
import 'package:client/notifier/interview_view/interview_view_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie_chart/pie_chart.dart';

/// 要支援レベル画面
class InterviewAnalyticsView extends ConsumerStatefulWidget {
  const InterviewAnalyticsView({super.key});

  @override
  ConsumerState<InterviewAnalyticsView> createState() =>
      _InterviewAnalyticsView();
}

class _InterviewAnalyticsView extends ConsumerState<InterviewAnalyticsView> {
  @override
  void initState() {
    super.initState();
    Future(() async {
      final notifier =
          ref.read(interviewAnalyticsViewNotifierProvider.notifier);
      notifier.setIsAnimated(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final interviewState = ref.watch(interviewViewNotifierProvider);
    final supportNecessityLevel = SupportNecessityLevel();
    final deviationFromMinimumAttendanceRate =
        supportNecessityLevel.getTitleAndParameter(
            SupportNecessityLevelElement.deviationFromMinimumAttendanceRate);
    final deviationFromPreferredCreditLevel =
        supportNecessityLevel.getTitleAndParameter(
            SupportNecessityLevelElement.deviationFromPreferredCreditLevel);
    final highAttendanceLowGpaRate = supportNecessityLevel.getTitleAndParameter(
        SupportNecessityLevelElement.highAttendanceLowGpaRate);
    final lowAttendanceAndLowGpaRate =
        supportNecessityLevel.getTitleAndParameter(
            SupportNecessityLevelElement.lowAttendanceAndLowGpaRate);
    Map<String, double> dataMap = {
      "1": interviewState.interviewAnalytics?.deviationFromMinimumAttendanceRate
              .toDouble() ??
          0,
      "2": interviewState.interviewAnalytics?.deviationFromPreferredCreditLevel
              .toDouble() ??
          0,
      "3": interviewState.interviewAnalytics?.highAttendanceLowGpaRate
              .toDouble() ??
          0,
      "4": interviewState.interviewAnalytics?.lowAtendanceAndLowGpaRate
              .toDouble() ??
          0,
    };

    return Scaffold(
      backgroundColor: ColorDefinitions.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorDefinitions.secondaryColor,
        title: const Text("面談結果"),
        titleTextStyle: const TextStyle(
          color: ColorDefinitions.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Card(
                color: ColorDefinitions.primaryColor,
                elevation: 5,
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    const Text(
                      "要支援レベル",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: PieChart(
                        dataMap: dataMap,
                        centerWidget: _centerWidget(),
                        animationDuration: const Duration(milliseconds: 800),
                        chartRadius: 140,
                        initialAngleInDegree: 270,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 32,
                        legendOptions: const LegendOptions(showLegends: false),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesOutside: true,
                          decimalPlaces: 1,
                        ),
                        totalValue: 100,
                        baseChartColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "要支援レベル内訳",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _supportNecessityLevelElement(
                        elementTitle: deviationFromMinimumAttendanceRate.$1,
                        parameter: deviationFromMinimumAttendanceRate.$2,
                        value: interviewState.interviewAnalytics
                                ?.deviationFromMinimumAttendanceRate
                                .toDouble() ??
                            0,
                        meterColor: deviationFromMinimumAttendanceRate.$3,
                      ),
                      _supportNecessityLevelElement(
                        elementTitle: deviationFromPreferredCreditLevel.$1,
                        parameter: deviationFromPreferredCreditLevel.$2,
                        value: interviewState.interviewAnalytics
                                ?.deviationFromPreferredCreditLevel
                                .toDouble() ??
                            0,
                        meterColor: deviationFromPreferredCreditLevel.$3,
                      ),
                      _supportNecessityLevelElement(
                        elementTitle: highAttendanceLowGpaRate.$1,
                        parameter: highAttendanceLowGpaRate.$2,
                        value: interviewState
                                .interviewAnalytics?.highAttendanceLowGpaRate
                                .toDouble() ??
                            0,
                        meterColor: highAttendanceLowGpaRate.$3,
                      ),
                      _supportNecessityLevelElement(
                        elementTitle: lowAttendanceAndLowGpaRate.$1,
                        parameter: lowAttendanceAndLowGpaRate.$2,
                        value: interviewState
                                .interviewAnalytics?.lowAtendanceAndLowGpaRate
                                .toDouble() ??
                            0,
                        meterColor: lowAttendanceAndLowGpaRate.$3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 要支援レベル円グラフ中央に表示するWidget
  Widget _centerWidget() {
    final interviewState = ref.watch(interviewViewNotifierProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${interviewState.interviewAnalytics?.supportNecessityLevel.toDouble() ?? 0}",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(" /100"),
      ],
    );
  }

  /// 要支援レベルの内訳を表示するWidget
  ///
  /// [parameter] 母数（その要素に割り振られているパラメータ）
  /// [value] 実際の値
  Widget _supportNecessityLevelElement({
    required String elementTitle,
    required double parameter,
    required double value,
    required Color meterColor,
  }) {
    final state = ref.watch(interviewAnalyticsViewNotifierProvider);
    const double meterHeight = 20;
    const double meterRadius = 20;
    double meterWidth = MediaQuery.of(context).size.width * 0.7;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              elementTitle,
              style: const TextStyle(fontSize: 16),
            ),
            IconButton(
              onPressed: () {
                // ボタン押下
                // TODO ボタンを押下したときの処理
              },
              icon: const Icon(Icons.info_outline, size: 20),
            )
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Stack(
              children: [
                Container(
                  width: meterWidth,
                  height: meterHeight,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(meterRadius),
                  ),
                ),
                AnimatedContainer(
                  width:
                      state.isAnimated ? (meterWidth * value) / parameter : 0,
                  height: meterHeight,
                  decoration: BoxDecoration(
                    color: meterColor,
                    borderRadius: BorderRadius.circular(meterRadius),
                  ),
                  duration: const Duration(milliseconds: 800),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Text(
              "$value",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(" /$parameter"),
          ],
        ),
      ],
    );
  }
}
