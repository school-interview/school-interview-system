//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InterviewAnalytics {
  /// Returns a new [InterviewAnalytics] instance.
  InterviewAnalytics({
    required this.id,
    required this.sessionId,
    this.session,
    required this.failToMoveToNextGrade,
    required this.deviationFromPreferredCreditLevel,
    required this.deviationFromMinimumAttendanceRate,
    required this.highAttendanceLowGpaRate,
    required this.lowAtendanceAndLowGpaRate,
    required this.supportNecessityLevel,
  });

  String id;

  String sessionId;

  InterviewSession? session;

  bool failToMoveToNextGrade;

  num deviationFromPreferredCreditLevel;

  num deviationFromMinimumAttendanceRate;

  num highAttendanceLowGpaRate;

  num lowAtendanceAndLowGpaRate;

  num supportNecessityLevel;

  @override
  bool operator ==(Object other) => identical(this, other) || other is InterviewAnalytics &&
    other.id == id &&
    other.sessionId == sessionId &&
    other.session == session &&
    other.failToMoveToNextGrade == failToMoveToNextGrade &&
    other.deviationFromPreferredCreditLevel == deviationFromPreferredCreditLevel &&
    other.deviationFromMinimumAttendanceRate == deviationFromMinimumAttendanceRate &&
    other.highAttendanceLowGpaRate == highAttendanceLowGpaRate &&
    other.lowAtendanceAndLowGpaRate == lowAtendanceAndLowGpaRate &&
    other.supportNecessityLevel == supportNecessityLevel;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (sessionId.hashCode) +
    (session == null ? 0 : session!.hashCode) +
    (failToMoveToNextGrade.hashCode) +
    (deviationFromPreferredCreditLevel.hashCode) +
    (deviationFromMinimumAttendanceRate.hashCode) +
    (highAttendanceLowGpaRate.hashCode) +
    (lowAtendanceAndLowGpaRate.hashCode) +
    (supportNecessityLevel.hashCode);

  @override
  String toString() => 'InterviewAnalytics[id=$id, sessionId=$sessionId, session=$session, failToMoveToNextGrade=$failToMoveToNextGrade, deviationFromPreferredCreditLevel=$deviationFromPreferredCreditLevel, deviationFromMinimumAttendanceRate=$deviationFromMinimumAttendanceRate, highAttendanceLowGpaRate=$highAttendanceLowGpaRate, lowAtendanceAndLowGpaRate=$lowAtendanceAndLowGpaRate, supportNecessityLevel=$supportNecessityLevel]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'session_id'] = this.sessionId;
    if (this.session != null) {
      json[r'session'] = this.session;
    } else {
      json[r'session'] = null;
    }
      json[r'fail_to_move_to_next_grade'] = this.failToMoveToNextGrade;
      json[r'deviation_from_preferred_credit_level'] = this.deviationFromPreferredCreditLevel;
      json[r'deviation_from_minimum_attendance_rate'] = this.deviationFromMinimumAttendanceRate;
      json[r'high_attendance_low_gpa_rate'] = this.highAttendanceLowGpaRate;
      json[r'low_atendance_and_low_gpa_rate'] = this.lowAtendanceAndLowGpaRate;
      json[r'support_necessity_level'] = this.supportNecessityLevel;
    return json;
  }

  /// Returns a new [InterviewAnalytics] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InterviewAnalytics? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "InterviewAnalytics[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "InterviewAnalytics[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return InterviewAnalytics(
        id: mapValueOfType<String>(json, r'id')!,
        sessionId: mapValueOfType<String>(json, r'session_id')!,
        session: InterviewSession.fromJson(json[r'session']),
        failToMoveToNextGrade: mapValueOfType<bool>(json, r'fail_to_move_to_next_grade')!,
        deviationFromPreferredCreditLevel: num.parse('${json[r'deviation_from_preferred_credit_level']}'),
        deviationFromMinimumAttendanceRate: num.parse('${json[r'deviation_from_minimum_attendance_rate']}'),
        highAttendanceLowGpaRate: num.parse('${json[r'high_attendance_low_gpa_rate']}'),
        lowAtendanceAndLowGpaRate: num.parse('${json[r'low_atendance_and_low_gpa_rate']}'),
        supportNecessityLevel: num.parse('${json[r'support_necessity_level']}'),
      );
    }
    return null;
  }

  static List<InterviewAnalytics> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <InterviewAnalytics>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InterviewAnalytics.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, InterviewAnalytics> mapFromJson(dynamic json) {
    final map = <String, InterviewAnalytics>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = InterviewAnalytics.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of InterviewAnalytics-objects as value to a dart map
  static Map<String, List<InterviewAnalytics>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<InterviewAnalytics>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = InterviewAnalytics.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'session_id',
    'fail_to_move_to_next_grade',
    'deviation_from_preferred_credit_level',
    'deviation_from_minimum_attendance_rate',
    'high_attendance_low_gpa_rate',
    'low_atendance_and_low_gpa_rate',
    'support_necessity_level',
  };
}

