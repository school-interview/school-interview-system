//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TeachersResponse {
  /// Returns a new [TeachersResponse] instance.
  TeachersResponse({
    this.teachers = const [],
    required this.count,
  });

  List<Teacher> teachers;

  int count;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TeachersResponse &&
    _deepEquality.equals(other.teachers, teachers) &&
    other.count == count;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (teachers.hashCode) +
    (count.hashCode);

  @override
  String toString() => 'TeachersResponse[teachers=$teachers, count=$count]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'teachers'] = this.teachers;
      json[r'count'] = this.count;
    return json;
  }

  /// Returns a new [TeachersResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TeachersResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TeachersResponse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TeachersResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TeachersResponse(
        teachers: Teacher.listFromJson(json[r'teachers']),
        count: mapValueOfType<int>(json, r'count')!,
      );
    }
    return null;
  }

  static List<TeachersResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TeachersResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TeachersResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TeachersResponse> mapFromJson(dynamic json) {
    final map = <String, TeachersResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TeachersResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TeachersResponse-objects as value to a dart map
  static Map<String, List<TeachersResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TeachersResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TeachersResponse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'teachers',
    'count',
  };
}

