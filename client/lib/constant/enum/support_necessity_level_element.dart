/// 要支援レベルの構成要素
enum SupportNecessityLevelElement {
  // 単位数が少ない
  deviationFromPreferredCreditLevel,
  // 出席率が低い
  deviationFromMinimumAttendanceRate,
  // 高出席率と低GPA
  highAttendanceLowGpaRate,
  // 低出席率と低GPA
  lowAttendanceAndLowGpaRate,
}