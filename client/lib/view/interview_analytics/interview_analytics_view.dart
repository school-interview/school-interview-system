import 'dart:core';

import 'package:client/constant/color.dart';
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
    final notifier = ref.read(interviewAnalyticsViewNotifierProvider.notifier);
    final interviewState = ref.watch(interviewViewNotifierProvider);
    // 以下、各要支援レベルを構成する要素
    const e1 = SupportLevel(element: SupportLevelEnum.attendanceRate);
    const e2 = SupportLevel(element: SupportLevelEnum.credit);
    const e3 = SupportLevel(element: SupportLevelEnum.highAttendanceLowGpa);
    const e4 = SupportLevel(element: SupportLevelEnum.lowAttendanceAndLowGpa);
    // 以下、要支援レベルを構成する要素の値
    var e1Value = notifier.getElementValue(
        interviewState.interviewAnalytics?.deviationFromMinimumAttendanceRate,
        e1.parameter);
    var e2Value = notifier.getElementValue(
        interviewState.interviewAnalytics?.deviationFromPreferredCreditLevel,
        e2.parameter);
    var e3Value = notifier.getElementValue(
        interviewState.interviewAnalytics?.highAttendanceLowGpaRate,
        e3.parameter);
    var e4Value = notifier.getElementValue(
        interviewState.interviewAnalytics?.lowAtendanceAndLowGpaRate,
        e3.parameter);

    // 要支援レベルを構成する要素の値リスト
    List<double> valueList = [
      double.parse(e1Value),
      double.parse(e2Value),
      double.parse(e3Value),
      double.parse(e4Value)
    ];
    // 円グラフに表示するデータ
    Map<String, double> dataMap = {};
    for (int i = 0; i < valueList.length; i++) {
      dataMap.addAll({"${i + 1}": valueList[i]});
    }

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
                        description: e1.description,
                        parameter: e1.parameter,
                        value: e1Value,
                        chartColor: e1.chartColor,
                      ),
                      _supportNecessityLevelElement(
                        description: e2.description,
                        parameter: e2.parameter,
                        value: e2Value,
                        chartColor: e2.chartColor,
                      ),
                      _supportNecessityLevelElement(
                        description: e3.description,
                        parameter: e3.parameter,
                        value: e3Value,
                        chartColor: e3.chartColor,
                      ),
                      _supportNecessityLevelElement(
                        description: e4.description,
                        parameter: e4.parameter,
                        value: e4Value,
                        chartColor: e4.chartColor,
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
          "${interviewState.interviewAnalytics?.supportNecessityLevel.toDouble().toStringAsFixed(1) ?? 0}",
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            // TODO 不要であれば削除
            IconButton(
              onPressed: () {
                // ボタン押下
                // TODO ボタンを押下したときの処理（内訳の詳細説明を表示する想定）
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
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(" /$parameter"),
          ],
        ),
      ],
    );
  }
}
