import 'dart:core';

import 'package:client/component/button_component.dart';
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
    final state = ref.watch(interviewAnalyticsViewNotifierProvider);
    final analytics = widget.interviewAnalytics;
    // 以下、総合点を構成する要素の値
    var e1Value = SupportLevel.attendance
        .getPointElementValue(analytics.deviationFromMinimumAttendanceRate);
    var e2Value = SupportLevel.credit
        .getPointElementValue(analytics.deviationFromPreferredCreditLevel);
    var e3Value = SupportLevel.highAttendanceLowGpa
        .getPointElementValue(analytics.highAttendanceLowGpaRate);
    var e4Value = SupportLevel.lowAttendanceLowGpa
        .getPointElementValue(analytics.lowAtendanceAndLowGpaRate);

    // Exception対策（なくても動作は問題ない）
    final scrollController = ScrollController();

    return PopScope(
      canPop: false,
      child: Scaffold(
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
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  if (analytics.advise != "" && analytics.advise != null) ...[
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                  ],

                  /// 進級条件に満たない場合と満たす場合で表示する内容を変える
                  analytics.failToMoveToNextGrade
                      ? const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("修得単位数が進級条件を満たしていないため、支援必須と判断されました。"),
                            Text("教員から連絡があった場合、速やかに対応してください。"),
                            SizedBox(height: 10),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "得点内訳",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            _SupportNecessityLevelElement(
                              label: SupportLevel.attendance.label,
                              description: SupportLevel.attendance.description,
                              parameter: SupportLevel.attendance.parameter,
                              value: e1Value,
                              chartColor: SupportLevel.attendance.chartColor,
                              isAnimated: state.isAnimated,
                            ),
                            _SupportNecessityLevelElement(
                              label: SupportLevel.credit.label,
                              description: SupportLevel.credit.description,
                              parameter: SupportLevel.credit.parameter,
                              value: e2Value,
                              chartColor: SupportLevel.credit.chartColor,
                              isAnimated: state.isAnimated,
                            ),
                            _SupportNecessityLevelElement(
                              label: SupportLevel.highAttendanceLowGpa.label,
                              description:
                                  SupportLevel.highAttendanceLowGpa.description,
                              parameter:
                                  SupportLevel.highAttendanceLowGpa.parameter,
                              value: e3Value,
                              chartColor:
                                  SupportLevel.highAttendanceLowGpa.chartColor,
                              isAnimated: state.isAnimated,
                            ),
                            _SupportNecessityLevelElement(
                              label: SupportLevel.lowAttendanceLowGpa.label,
                              description:
                                  SupportLevel.lowAttendanceLowGpa.description,
                              parameter:
                                  SupportLevel.lowAttendanceLowGpa.parameter,
                              value: e4Value,
                              chartColor:
                                  SupportLevel.lowAttendanceLowGpa.chartColor,
                              isAnimated: state.isAnimated,
                            ),
                            Card(
                              color: ColorDefinitions.primaryColor,
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              elevation: 5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      (100 - analytics.supportNecessityLevel)
                                          .toStringAsFixed(1),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text("/100"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                  const Text("以上で面談は終了です。"),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: ButtonComponent().normalButton(
                      labelText: "ログイン画面へ戻る",
                      onTapButton: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 要支援レベルの内訳を表示するWidget
///
/// [label] その要支援レベル要素の説明文
/// [parameter] 母数（その要素に割り振られているパラメータ）
/// [value] 実際の値
/// [chartColor] 棒グラフの色
/// [isAnimated] アニメーション中かどうかのフラグ
class _SupportNecessityLevelElement extends StatelessWidget {
  const _SupportNecessityLevelElement({
    required this.label,
    required this.parameter,
    required this.description,
    required this.value,
    required this.chartColor,
    required this.isAnimated,
  });

  final String label;
  final String description;
  final double parameter;
  final String value;
  final Color chartColor;
  final bool isAnimated;

  @override
  Widget build(BuildContext context) {
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
                label,
                style: const TextStyle(fontSize: 16),
              ),
              // TODO 不要であれば削除
              const SizedBox(width: 8),
              Tooltip(
                padding: const EdgeInsets.all(10),
                message: description,
                preferBelow: false,
                child: const Icon(
                  Icons.info_outline,
                  size: 20,
                ),
              ),
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
                    width: isAnimated
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
