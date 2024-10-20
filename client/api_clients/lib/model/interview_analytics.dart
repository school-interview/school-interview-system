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
      json[r'sessionId'] = this.sessionId;
    if (this.session != null) {
      json[r'session'] = this.session;
    } else {
      json[r'session'] = null;
    }
      json[r'failToMoveToNextGrade'] = this.failToMoveToNextGrade;
      json[r'deviationFromPreferredCreditLevel'] = this.deviationFromPreferredCreditLevel;
      json[r'deviationFromMinimumAttendanceRate'] = this.deviationFromMinimumAttendanceRate;
      json[r'highAttendanceLowGpaRate'] = this.highAttendanceLowGpaRate;
      json[r'lowAtendanceAndLowGpaRate'] = this.lowAtendanceAndLowGpaRate;
      json[r'supportNecessityLevel'] = this.supportNecessityLevel;
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
        sessionId: mapValueOfType<String>(json, r'sessionId')!,
        session: InterviewSession.fromJson(json[r'session']),
        failToMoveToNextGrade: mapValueOfType<bool>(json, r'failToMoveToNextGrade')!,
        deviationFromPreferredCreditLevel: num.parse('${json[r'deviationFromPreferredCreditLevel']}'),
        deviationFromMinimumAttendanceRate: num.parse('${json[r'deviationFromMinimumAttendanceRate']}'),
        highAttendanceLowGpaRate: num.parse('${json[r'highAttendanceLowGpaRate']}'),
        lowAtendanceAndLowGpaRate: num.parse('${json[r'lowAtendanceAndLowGpaRate']}'),
        supportNecessityLevel: num.parse('${json[r'supportNecessityLevel']}'),
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
    'sessionId',
    'failToMoveToNextGrade',
    'deviationFromPreferredCreditLevel',
    'deviationFromMinimumAttendanceRate',
    'highAttendanceLowGpaRate',
    'lowAtendanceAndLowGpaRate',
    'supportNecessityLevel',
  };
}

