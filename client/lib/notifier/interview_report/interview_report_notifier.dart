import 'package:client/app.dart';
import 'package:client/constant/result.dart';
import 'package:client/notifier/interview_report/interview_report_state.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/interview_report/interview_report_repository.dart';
import 'package:client/repository/interview_report/inteview_report_repository_impl.dart';
import 'package:openapi/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interview_report_notifier.g.dart';

@riverpod
class InterviewReportNotifier extends _$InterviewReportNotifier {
  @override
  InterviewReportState build() {
    return const InterviewReportState();
  }

  /// 以下、setter
  setResult(Result? result) => state = state.copyWith(result: result);

  _setInterviewReport(InterviewReportsResponse? interviewReport) =>
      state = state.copyWith(interviewReport: interviewReport);

  /// ログインリポジトリ
  final InterviewReportRepository _interviewReportRepository =
      InterviewReportRepositoryImpl();

  /// ユーザー情報取得API
  Future<void> getInterviewReport() async {
    logger.i("run getInterviewReport()");
    try {
      ApiResult<InterviewReportsResponse> response =
          await _interviewReportRepository.getInterviewReport();
      switch (response.statusCode) {
        case 200:
          _setInterviewReport(response.data!);
          setResult(Result.success);
          break;
        default:
          // TODO API失敗時の処理
          setResult(Result.fail);
          break;
      }
      logger.t("responseData:${response.data}");
    } on Exception catch (e) {
      logger.e(e.toString());
      return;
    }
  }
}
