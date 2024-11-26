import 'dart:ui';

import 'package:client/constant/enum/support_level_enum.dart';

/// 要支援レベルの情報を取得するクラス
class SupportLevel {
  const SupportLevel({
    required this.element,
  });

  final SupportLevelEnum element;

  /// 各要支援レベルの構成要素
  static const attendance =
      SupportLevel(element: SupportLevelEnum.attendanceRate);
  static const credit = SupportLevel(element: SupportLevelEnum.credit);
  static const highAttendanceLowGpa =
      SupportLevel(element: SupportLevelEnum.highAttendanceLowGpa);
  static const lowAttendanceLowGpa =
      SupportLevel(element: SupportLevelEnum.lowAttendanceAndLowGpa);

  /// 各内訳要素のラベルを取得する
  String get label {
    switch (element) {
      case SupportLevelEnum.attendanceRate:
        return "出席率が66%以上である";
      case SupportLevelEnum.credit:
        return "修得単位数が推奨数以上である";
      case SupportLevelEnum.highAttendanceLowGpa:
        return "I.GPAが高い（出席率が高い）";
      case SupportLevelEnum.lowAttendanceAndLowGpa:
        return "II.GPAが高い（出席率が低い）";
    }
  }

  /// 各内訳要素の説明文を取得する
  String get description {
    switch (element) {
      case SupportLevelEnum.attendanceRate:
        return "出席率が66%を下回る場合に減点されます。";
      case SupportLevelEnum.credit:
        return "修得単位数が推奨数を下回る場合に減点されます。";
      case SupportLevelEnum.highAttendanceLowGpa:
        return "出席率が80%以上で、かつGPAが2.0より低い場合に減点されます。";
      case SupportLevelEnum.lowAttendanceAndLowGpa:
        return "出席率が80%を下回り、かつGPAが2.0より低い場合に減点されます。";
    }
  }

  /// 各内訳要素のパラメータを取得する
  double get parameter {
    switch (element) {
      case SupportLevelEnum.attendanceRate:
        return 32.5;
      case SupportLevelEnum.credit:
        return 27.5;
      case SupportLevelEnum.highAttendanceLowGpa:
        return 22.5;
      case SupportLevelEnum.lowAttendanceAndLowGpa:
        return 17.5;
    }
  }

  /// 要支援レベルの内訳の値を取得する
  String getElementValue(num? factor) {
    final value = ((factor?.toDouble() ?? 0) * parameter).toStringAsFixed(1);
    return value;
  }

  /// 総合点の内訳の値を取得する
  String getPointElementValue(num? factor) {
    final value =
        (parameter - (factor?.toDouble() ?? 0) * parameter).toStringAsFixed(1);
    return value;
  }

  /// 各内訳要素のグラフに用いるカラーを取得する
  Color get chartColor {
    switch (element) {
      case SupportLevelEnum.attendanceRate:
        return const Color(0xFFff7675);
      case SupportLevelEnum.credit:
        return const Color(0xFF74b9ff);
      case SupportLevelEnum.highAttendanceLowGpa:
        return const Color(0xFF55efc4);
      case SupportLevelEnum.lowAttendanceAndLowGpa:
        return const Color(0xFFffeaa7);
    }
  }
}
