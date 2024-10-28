import 'dart:ui';

/// 要支援レベルの情報を取得するクラス
class SupportLevel {
  const SupportLevel({
    required this.element,
  });

  final SupportLevelEnum element;

  /// 各内訳要素の説明文を取得する
  String get description {
    switch (element) {
      case SupportLevelEnum.attendanceRate:
        return "出席率が66%を下回る";
      case SupportLevelEnum.credit:
        return "修得単位数が推奨数を下回る";
      case SupportLevelEnum.highAttendanceLowGpa:
        return "出席率が高く、GPAが低い";
      case SupportLevelEnum.lowAttendanceAndLowGpa:
        return "出席率が低く、GPAが低い";
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

/// 要支援レベルの構成要素
enum SupportLevelEnum {
  // 出席率が低い
  attendanceRate,
  // 単位数が少ない
  credit,
  // 高出席率と低GPA
  highAttendanceLowGpa,
  // 低出席率と低GPA
  lowAttendanceAndLowGpa,
}
