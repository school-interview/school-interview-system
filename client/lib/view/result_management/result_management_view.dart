import 'package:client/constant/color.dart';
import 'package:client/notifier/interview_report/interview_report_notifier.dart';
import 'package:client/ui_core/result_management_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 面談結果管理画面（教員向けの画面）
class ResultManagementView extends ConsumerStatefulWidget {
  const ResultManagementView({super.key});

  @override
  ConsumerState<ResultManagementView> createState() => _ResultManagementView();
}

class _ResultManagementView extends ConsumerState<ResultManagementView> {
  @override
  void initState() {
    super.initState();
    Future(() async {
      final interviewReportNotifier =
          ref.read(interviewReportNotifierProvider.notifier);
      await interviewReportNotifier.getInterviewReport();
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 表のヘッダーラベル（項目）
    final labels = List<DataColumn>.generate(
      ResultManagementTable.headerSections.length,
      (int index) => DataColumn(
        label: SizedBox(
          width: 120,
          child: Flexible(
            child: Text(
              ResultManagementTable.headerSections[index],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );

    final interviewReportState = ref.watch(interviewReportNotifierProvider);
    final reports = interviewReportState.interviewReport?.reports ?? [];

    /// 表の値一覧
    final values = List<DataRow>.generate(2, (int index) {
      return DataRow(cells: [
        // DataCell(Text(reports[index].user.name)),
        // DataCell(Text(reports[index].user.student?.studentId ?? "")),
        // DataCell(Text(reports[index].user.student?.department ?? "")),
        // DataCell(Text(SupportNecessityLevelFormatter.failToMoveToNextGrade(
        //     reports[index].analytics.failToMoveToNextGrade))),
        // DataCell(Text(SupportLevel.attendance.getElementValue(
        //     reports[index].analytics.deviationFromMinimumAttendanceRate))),
        // DataCell(Text(SupportLevel.credit.getElementValue(
        //     reports[index].analytics.deviationFromPreferredCreditLevel))),
        // DataCell(Text(SupportLevel.highAttendanceLowGpa.getElementValue(
        //     reports[index].analytics.highAttendanceLowGpaRate))),
        // DataCell(Text(SupportLevel.lowAttendanceLowGpa.getElementValue(
        //     reports[index].analytics.lowAtendanceAndLowGpaRate))),
        // DataCell(Text("${reports[index].analytics.supportNecessityLevel}")),
        DataCell(Flexible(child: Text("名前だよヨヨヨヨヨヨヨヨヨヨヨヨよよおy"))),
        DataCell(Text("名前")),
        DataCell(Text("名前")),
        DataCell(Text("名前")),
        DataCell(Text("名前")),
        DataCell(Text("名前")),
        DataCell(Text("名前")),
        DataCell(Text("名前")),
        DataCell(Text("名前")),
      ]);
    }, growable: false);

    return Scaffold(
      backgroundColor: ColorDefinitions.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorDefinitions.secondaryColor,
        title: const Text("面談結果管理画面"),
        titleTextStyle: const TextStyle(
          color: ColorDefinitions.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 16),
          child: _table(labels, values),
        ),
      ),
    );
  }

  /// 表を生成するWidget
  Widget _table(List<DataColumn> columnList, List<DataRow> rowList) {
    return ListView(
      children: [
        Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(columns: columnList, rows: rowList),
          ),
        )
      ],
    );
  }
}
