import 'package:openapi/api.dart';

/// ダミーデータを持つクラス
class DummyData {
  /// 要支援レベルダミー
  static var dummyInterviewAnalytics = InterviewAnalytics(
    id: "id",
    sessionId: "sessionId",
    failToMoveToNextGrade: false,
    deviationFromPreferredCreditLevel: 10.0,
    deviationFromMinimumAttendanceRate: 15.0,
    highAttendanceLowGpaRate: 3.0,
    lowAtendanceAndLowGpaRate: 6.0,
    supportNecessityLevel: 34.0,
  );
}
