//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StudentUpdate {
  /// Returns a new [StudentUpdate] instance.
  StudentUpdate({
    required this.studentId,
    required this.department,
    required this.semester,
  });

  String studentId;

  String department;

  int semester;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StudentUpdate &&
    other.studentId == studentId &&
    other.department == department &&
    other.semester == semester;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (studentId.hashCode) +
    (department.hashCode) +
    (semester.hashCode);

  @override
  String toString() => 'StudentUpdate[studentId=$studentId, department=$department, semester=$semester]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'studentId'] = this.studentId;
      json[r'department'] = this.department;
      json[r'semester'] = this.semester;
    return json;
  }

  /// Returns a new [StudentUpdate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StudentUpdate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StudentUpdate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StudentUpdate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StudentUpdate(
        studentId: mapValueOfType<String>(json, r'studentId')!,
        department: mapValueOfType<String>(json, r'department')!,
        semester: mapValueOfType<int>(json, r'semester')!,
      );
    }
    return null;
  }

  static List<StudentUpdate> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StudentUpdate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StudentUpdate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StudentUpdate> mapFromJson(dynamic json) {
    final map = <String, StudentUpdate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StudentUpdate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StudentUpdate-objects as value to a dart map
  static Map<String, List<StudentUpdate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StudentUpdate>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StudentUpdate.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'studentId',
    'department',
    'semester',
  };
}

