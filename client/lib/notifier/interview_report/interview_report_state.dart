import 'package:client/constant/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:openapi/api.dart';

part 'interview_report_state.freezed.dart';

@freezed
abstract class InterviewReportState with _$InterviewReportState {
  /// 面談結果の状態を保持する
  const factory InterviewReportState({
    /// API処理結果
    Result? result,

    /// 面談結果一覧
    InterviewReportsResponse? interviewReport,
  }) = _InterviewReportState;
}
