import 'dart:core';

import 'package:client/constant/color.dart';
import 'package:client/notifier/interview_analytics_view/interview_analytics_view_notifier.dart';
import 'package:client/ui_core/support_necessity_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openapi/api.dart';

/// 要支援レベル画面
class InterviewAnalyticsView extends ConsumerStatefulWidget {
  const InterviewAnalyticsView({super.key, required this.interviewAnalytics});

  final InterviewAnalytics interviewAnalytics;

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
    final analytics = widget.interviewAnalytics;

    // 以下、要支援レベルを構成する要素の値
    var e1Value = SupportLevel.attendance
        .getElementValue(analytics.deviationFromMinimumAttendanceRate);
    var e2Value = SupportLevel.credit
        .getElementValue(analytics.deviationFromPreferredCreditLevel);
    var e3Value = SupportLevel.highAttendanceLowGpa
        .getElementValue(analytics.highAttendanceLowGpaRate);
    var e4Value = SupportLevel.lowAttendanceLowGpa
        .getElementValue(analytics.lowAtendanceAndLowGpaRate);

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
                  Center(
                    child: Card(
                      color: ColorDefinitions.primaryColor,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.smart_toy,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "AIアドバイス：",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text("${analytics.advise}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "要支援レベル内訳",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  /// 進級条件に満たない場合と満たす場合で表示する内容を変える
                  analytics.failToMoveToNextGrade
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text("修得単位数が進級条件に満たないため、支援必須と判断されました。"),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
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
                            const SizedBox(height: 14),
                            Card(
                              color: ColorDefinitions.primaryColor,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "総合  ${analytics.supportNecessityLevel}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(" /100"),
                                  ],
                                ),
                              ),
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
              const SizedBox(width: 10),
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
