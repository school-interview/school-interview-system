//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InterviewReport {
  /// Returns a new [InterviewReport] instance.
  InterviewReport({
    required this.user,
    required this.interviewSession,
    required this.analytics,
  });

  User user;

  InterviewSession interviewSession;

  InterviewAnalytics analytics;

  @override
  bool operator ==(Object other) => identical(this, other) || other is InterviewReport &&
    other.user == user &&
    other.interviewSession == interviewSession &&
    other.analytics == analytics;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (user.hashCode) +
    (interviewSession.hashCode) +
    (analytics.hashCode);

  @override
  String toString() => 'InterviewReport[user=$user, interviewSession=$interviewSession, analytics=$analytics]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'user'] = this.user;
      json[r'interview_session'] = this.interviewSession;
      json[r'analytics'] = this.analytics;
    return json;
  }

  /// Returns a new [InterviewReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InterviewReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "InterviewReport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "InterviewReport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return InterviewReport(
        user: User.fromJson(json[r'user'])!,
        interviewSession: InterviewSession.fromJson(json[r'interview_session'])!,
        analytics: InterviewAnalytics.fromJson(json[r'analytics'])!,
      );
    }
    return null;
  }

  static List<InterviewReport> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <InterviewReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InterviewReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, InterviewReport> mapFromJson(dynamic json) {
    final map = <String, InterviewReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = InterviewReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of InterviewReport-objects as value to a dart map
  static Map<String, List<InterviewReport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<InterviewReport>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = InterviewReport.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'user',
    'interview_session',
    'analytics',
  };
}

