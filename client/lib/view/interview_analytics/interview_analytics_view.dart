import 'dart:core';

import 'package:client/app.dart';
import 'package:client/constant/color.dart';
import 'package:client/constant/dummy_data/dummy_data.dart';
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
      // initial logic
    });
  }

  @override
  Widget build(BuildContext context) {
    final dummyData = DummyData.dummyInterviewAnalytics;
    final other = 100 -
        (dummyData.deviationFromPreferredCreditLevel +
            dummyData.deviationFromMinimumAttendanceRate +
            dummyData.highAttendanceLowGpaRate +
            dummyData.lowAtendanceAndLowGpaRate);
    Map<String, double> dataMap = {
      "Flutter": dummyData.deviationFromPreferredCreditLevel.toDouble(),
      "React": dummyData.deviationFromMinimumAttendanceRate.toDouble(),
      "Xamarin": dummyData.highAttendanceLowGpaRate.toDouble(),
      "Ionic": dummyData.lowAtendanceAndLowGpaRate.toDouble(),
      "": other.toDouble(),
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
                        centerWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${dummyData.supportNecessityLevel}",
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const Text(" /100"),
                          ],
                        ),
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
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "要支援レベル内訳",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _supportNecessityLevelElement(
                          elementTitle: "ここです", parameter: 35, number: 20),
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

  /// 要支援レベルの内訳を表示するWidget
  Widget _supportNecessityLevelElement(
      {required String elementTitle,
      required int parameter,
      required double number}) {
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
                logger.i("$meterWidth");
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
                  width: (meterWidth * number) / parameter,
                  height: meterHeight,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(meterRadius),
                  ),
                ),
                Container(
                  width: meterWidth,
                  height: meterHeight,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(meterRadius),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Text(
              "$number",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(" /$parameter"),
          ],
        ),
      ],
    );
  }
}
