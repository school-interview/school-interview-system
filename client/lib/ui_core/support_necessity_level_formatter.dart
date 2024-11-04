/// 要支援レベルの各データをアプリ表示用にフォーマットするクラス
class SupportNecessityLevelFormatter {
  /// 修得単位数が進級条件を満たさない
  static String failToMoveToNextGrade(bool failToMoveToNextGrade) {
    if (failToMoveToNextGrade) {
      return "不可";
    } else {
      return "可";
    }
  }
}
