import 'dart:core';

import 'package:client/constant/color.dart';
import 'package:client/notifier/interview_analytics_view/interview_analytics_view_notifier.dart';
import 'package:client/notifier/interview_view/interview_view_notifier.dart';
import 'package:client/ui_core/support_necessity_level.dart';
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
    final notifier = ref.read(interviewAnalyticsViewNotifierProvider.notifier);
    final interviewState = ref.watch(interviewViewNotifierProvider);
    final analytics = interviewState.interviewAnalytics;

    // 以下、要支援レベルを構成する要素の値
    var e1Value = SupportLevel.attendance
        .getElementValue(analytics?.deviationFromMinimumAttendanceRate);
    var e2Value = SupportLevel.credit
        .getElementValue(analytics?.deviationFromPreferredCreditLevel);
    var e3Value = SupportLevel.highAttendanceLowGpa
        .getElementValue(analytics?.highAttendanceLowGpaRate);
    var e4Value = SupportLevel.lowAttendanceLowGpa
        .getElementValue(analytics?.lowAtendanceAndLowGpaRate);

    // 要支援レベルを構成する要素の値リスト
    List<double> valueList = [
      double.parse(e1Value),
      double.parse(e2Value),
      double.parse(e3Value),
      double.parse(e4Value)
    ];
    // 円グラフに表示するデータ
    final isFullScore =
        interviewState.interviewAnalytics?.failToMoveToNextGrade ?? false;
    Map<String, double> dataMap =
        notifier.createChartDataMap(valueList, isFullScore);

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
        child: Scrollbar(
          child: SingleChildScrollView(
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
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: PieChart(
                            dataMap: dataMap,
                            centerWidget: _centerWidget(isFullScore),
                            animationDuration:
                                const Duration(milliseconds: 800),
                            chartRadius: 140,
                            initialAngleInDegree: 270,
                            chartType: ChartType.ring,
                            ringStrokeWidth: 32,
                            legendOptions:
                                const LegendOptions(showLegends: false),
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

                  /// 進級条件に満たない場合と満たす場合で表示する内容を変える
                  isFullScore
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text("修得単位数が進級条件に満たないため、支援必須と判断されました。"),
                        )
                      : Column(
                          children: [
                            _supportNecessityLevelElement(
                              description: SupportLevel.attendance.description,
                              parameter: SupportLevel.attendance.parameter,
                              value: e1Value,
                              chartColor: SupportLevel.attendance.chartColor,
                            ),
                            _supportNecessityLevelElement(
                              description: SupportLevel.credit.description,
                              parameter: SupportLevel.credit.parameter,
                              value: e2Value,
                              chartColor: SupportLevel.credit.chartColor,
                            ),
                            _supportNecessityLevelElement(
                              description:
                                  SupportLevel.highAttendanceLowGpa.description,
                              parameter:
                                  SupportLevel.highAttendanceLowGpa.parameter,
                              value: e3Value,
                              chartColor:
                                  SupportLevel.highAttendanceLowGpa.chartColor,
                            ),
                            _supportNecessityLevelElement(
                              description:
                                  SupportLevel.lowAttendanceLowGpa.description,
                              parameter:
                                  SupportLevel.lowAttendanceLowGpa.parameter,
                              value: e4Value,
                              chartColor:
                                  SupportLevel.lowAttendanceLowGpa.chartColor,
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 要支援レベル円グラフ中央に表示するWidget
  Widget _centerWidget(bool isFullScore) {
    final interviewState = ref.watch(interviewViewNotifierProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isFullScore
              ? "100"
              : "${interviewState.interviewAnalytics?.supportNecessityLevel.toDouble().toStringAsFixed(1) ?? 0}",
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
    required String description,
    required double parameter,
    required String value,
    required Color chartColor,
  }) {
    final state = ref.watch(interviewAnalyticsViewNotifierProvider);
    const double meterHeight = 20;
    const double meterRadius = 20;
    double meterWidth = MediaQuery.of(context).size.width * 0.6;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              // TODO 不要であれば削除
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  // ボタン押下
                  // TODO ボタンを押下したときの処理（内訳の詳細説明を表示する想定）
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.info_outline,
                  size: 20,
                ),
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
                    width: state.isAnimated
                        ? (meterWidth * double.parse(value)) / parameter
                        : 0,
                    height: meterHeight,
                    decoration: BoxDecoration(
                      color: chartColor,
                      borderRadius: BorderRadius.circular(meterRadius),
                    ),
                    duration: const Duration(milliseconds: 800),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                value,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(" /$parameter"),
            ],
          ),
        ],
      ),
    );
  }
}
