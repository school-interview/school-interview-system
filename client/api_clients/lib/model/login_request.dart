//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LoginRequest {
  /// Returns a new [LoginRequest] instance.
  LoginRequest({
    required this.studentId,
    required this.name,
    required this.department,
    required this.semester,
  });

  String studentId;

  String name;

  String department;

  int semester;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LoginRequest &&
    other.studentId == studentId &&
    other.name == name &&
    other.department == department &&
    other.semester == semester;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (studentId.hashCode) +
    (name.hashCode) +
    (department.hashCode) +
    (semester.hashCode);

  @override
  String toString() => 'LoginRequest[studentId=$studentId, name=$name, department=$department, semester=$semester]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'student_id'] = this.studentId;
      json[r'name'] = this.name;
      json[r'department'] = this.department;
      json[r'semester'] = this.semester;
    return json;
  }

  /// Returns a new [LoginRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LoginRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LoginRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LoginRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LoginRequest(
        studentId: mapValueOfType<String>(json, r'student_id')!,
        name: mapValueOfType<String>(json, r'name')!,
        department: mapValueOfType<String>(json, r'department')!,
        semester: mapValueOfType<int>(json, r'semester')!,
      );
    }
    return null;
  }

  static List<LoginRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LoginRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LoginRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LoginRequest> mapFromJson(dynamic json) {
    final map = <String, LoginRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LoginRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LoginRequest-objects as value to a dart map
  static Map<String, List<LoginRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LoginRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LoginRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'student_id',
    'name',
    'department',
    'semester',
  };
}

