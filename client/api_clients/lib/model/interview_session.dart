//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InterviewSession {
  /// Returns a new [InterviewSession] instance.
  InterviewSession({
    required this.id,
    required this.userId,
    required this.user,
    required this.teacherId,
    required this.teacher,
    required this.startAt,
    required this.progress,
    required this.done,
  });

  String id;

  String userId;

  User? user;

  String teacherId;

  Teacher? teacher;

  DateTime startAt;

  int progress;

  bool done;

  @override
  bool operator ==(Object other) => identical(this, other) || other is InterviewSession &&
    other.id == id &&
    other.userId == userId &&
    other.user == user &&
    other.teacherId == teacherId &&
    other.teacher == teacher &&
    other.startAt == startAt &&
    other.progress == progress &&
    other.done == done;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (userId.hashCode) +
    (user == null ? 0 : user!.hashCode) +
    (teacherId.hashCode) +
    (teacher == null ? 0 : teacher!.hashCode) +
    (startAt.hashCode) +
    (progress.hashCode) +
    (done.hashCode);

  @override
  String toString() => 'InterviewSession[id=$id, userId=$userId, user=$user, teacherId=$teacherId, teacher=$teacher, startAt=$startAt, progress=$progress, done=$done]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'user_id'] = this.userId;
    if (this.user != null) {
      json[r'user'] = this.user;
    } else {
      json[r'user'] = null;
    }
      json[r'teacher_id'] = this.teacherId;
    if (this.teacher != null) {
      json[r'teacher'] = this.teacher;
    } else {
      json[r'teacher'] = null;
    }
      json[r'start_at'] = this.startAt.toUtc().toIso8601String();
      json[r'progress'] = this.progress;
      json[r'done'] = this.done;
    return json;
  }

  /// Returns a new [InterviewSession] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InterviewSession? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "InterviewSession[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "InterviewSession[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return InterviewSession(
        id: mapValueOfType<String>(json, r'id')!,
        userId: mapValueOfType<String>(json, r'user_id')!,
        user: User.fromJson(json[r'user']),
        teacherId: mapValueOfType<String>(json, r'teacher_id')!,
        teacher: Teacher.fromJson(json[r'teacher']),
        startAt: mapDateTime(json, r'start_at', r'')!,
        progress: mapValueOfType<int>(json, r'progress')!,
        done: mapValueOfType<bool>(json, r'done')!,
      );
    }
    return null;
  }

  static List<InterviewSession> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <InterviewSession>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InterviewSession.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, InterviewSession> mapFromJson(dynamic json) {
    final map = <String, InterviewSession>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = InterviewSession.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of InterviewSession-objects as value to a dart map
  static Map<String, List<InterviewSession>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<InterviewSession>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = InterviewSession.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'user_id',
    'user',
    'teacher_id',
    'teacher',
    'start_at',
    'progress',
    'done',
  };
}
