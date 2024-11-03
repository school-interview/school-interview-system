//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Student {
  /// Returns a new [Student] instance.
  Student({
    required this.id,
    required this.userId,
    this.user,
    this.studentId,
    this.department,
    this.semester,
  });

  String id;

  String userId;

  User? user;

  String? studentId;

  String? department;

  /// Minimum value: 1
  /// Maximum value: 8
  int? semester;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Student &&
    other.id == id &&
    other.userId == userId &&
    other.user == user &&
    other.studentId == studentId &&
    other.department == department &&
    other.semester == semester;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (userId.hashCode) +
    (user == null ? 0 : user!.hashCode) +
    (studentId == null ? 0 : studentId!.hashCode) +
    (department == null ? 0 : department!.hashCode) +
    (semester == null ? 0 : semester!.hashCode);

  @override
  String toString() => 'Student[id=$id, userId=$userId, user=$user, studentId=$studentId, department=$department, semester=$semester]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'userId'] = this.userId;
    if (this.user != null) {
      json[r'user'] = this.user;
    } else {
      json[r'user'] = null;
    }
    if (this.studentId != null) {
      json[r'studentId'] = this.studentId;
    } else {
      json[r'studentId'] = null;
    }
    if (this.department != null) {
      json[r'department'] = this.department;
    } else {
      json[r'department'] = null;
    }
    if (this.semester != null) {
      json[r'semester'] = this.semester;
    } else {
      json[r'semester'] = null;
    }
    return json;
  }

  /// Returns a new [Student] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Student? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Student[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Student[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Student(
        id: mapValueOfType<String>(json, r'id')!,
        userId: mapValueOfType<String>(json, r'userId')!,
        user: User.fromJson(json[r'user']),
        studentId: mapValueOfType<String>(json, r'studentId'),
        department: mapValueOfType<String>(json, r'department'),
        semester: mapValueOfType<int>(json, r'semester'),
      );
    }
    return null;
  }

  static List<Student> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Student>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Student.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Student> mapFromJson(dynamic json) {
    final map = <String, Student>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Student.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Student-objects as value to a dart map
  static Map<String, List<Student>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Student>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Student.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'userId',
  };
}

