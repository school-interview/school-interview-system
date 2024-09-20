//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StartInterviewResponse {
  /// Returns a new [StartInterviewResponse] instance.
  StartInterviewResponse({
    required this.interviewSession,
    required this.messageFromTeacher,
  });

  InterviewSession interviewSession;

  String messageFromTeacher;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StartInterviewResponse &&
    other.interviewSession == interviewSession &&
    other.messageFromTeacher == messageFromTeacher;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (interviewSession.hashCode) +
    (messageFromTeacher.hashCode);

  @override
  String toString() => 'StartInterviewResponse[interviewSession=$interviewSession, messageFromTeacher=$messageFromTeacher]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'interview_session'] = this.interviewSession;
      json[r'message_from_teacher'] = this.messageFromTeacher;
    return json;
  }

  /// Returns a new [StartInterviewResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StartInterviewResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StartInterviewResponse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StartInterviewResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StartInterviewResponse(
        interviewSession: InterviewSession.fromJson(json[r'interview_session'])!,
        messageFromTeacher: mapValueOfType<String>(json, r'message_from_teacher')!,
      );
    }
    return null;
  }

  static List<StartInterviewResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StartInterviewResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StartInterviewResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StartInterviewResponse> mapFromJson(dynamic json) {
    final map = <String, StartInterviewResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StartInterviewResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StartInterviewResponse-objects as value to a dart map
  static Map<String, List<StartInterviewResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StartInterviewResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StartInterviewResponse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'interview_session',
    'message_from_teacher',
  };
}

