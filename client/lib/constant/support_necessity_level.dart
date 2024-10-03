import 'dart:ui';

import 'package:client/constant/enum/support_necessity_level_element.dart';

/// 要支援レベルの情報を取得するクラス
class SupportNecessityLevel {
  // タイトルとパラメータを取得する
  (String, double, Color) getTitleAndParameter(SupportNecessityLevelElement supportNecessityLevelElement) {
    switch (supportNecessityLevelElement) {
      case SupportNecessityLevelElement.deviationFromMinimumAttendanceRate:
        return ("出席率が66%を下回る", 32.5, const Color(0xFFff7675));
      case SupportNecessityLevelElement.deviationFromPreferredCreditLevel:
        return ("修得単位数が足りない", 27.5, const Color(0xFF74b9ff));
      case SupportNecessityLevelElement.highAttendanceLowGpaRate:
        return ("出席率が高く、GPAが低い", 22.5, const Color(0xFF55efc4));
      case SupportNecessityLevelElement.lowAttendanceAndLowGpaRate:
        return ("出席率が低く、GPAが低い", 17.5, const Color(0xFFffeaa7));
    }
  }
}