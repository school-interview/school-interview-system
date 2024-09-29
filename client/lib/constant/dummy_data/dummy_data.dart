import 'package:openapi/api.dart';

/// ダミーデータを持つクラス
class DummyData {
  /// 要支援レベルダミー
  static var dummyInterviewAnalytics = InterviewAnalytics(
    id: "id",
    sessionId: "sessionId",
    failToMoveToNextGrade: false,
    deviationFromPreferredCreditLevel: 0,
    deviationFromMinimumAttendanceRate: 0,
    highAttendanceLowGpaRate: 0,
    lowAtendanceAndLowGpaRate: 0,
    supportNecessityLevel: 0,
  );
}
