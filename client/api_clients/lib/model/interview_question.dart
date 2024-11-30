//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InterviewQuestion {
  /// Returns a new [InterviewQuestion] instance.
  InterviewQuestion({
    required this.id,
    required this.question,
    required this.order,
    required this.groupId,
    required this.conditionTargetOperandDataType,
    required this.conditionLeftOperand,
    required this.conditionLeftOperator,
    required this.conditionRightOperand,
    required this.conditionRightOperator,
    required this.prompt,
    required this.description,
    required this.extractionDataType,
  });

  String id;

  String question;

  int order;

  String groupId;

  InterviewQuestionConditionTargetOperandDataTypeEnum? conditionTargetOperandDataType;

  String? conditionLeftOperand;

  InterviewQuestionConditionLeftOperatorEnum? conditionLeftOperator;

  String? conditionRightOperand;

  InterviewQuestionConditionRightOperatorEnum? conditionRightOperator;

  String prompt;

  String? description;

  InterviewQuestionExtractionDataTypeEnum extractionDataType;

  @override
  bool operator ==(Object other) => identical(this, other) || other is InterviewQuestion &&
    other.id == id &&
    other.question == question &&
    other.order == order &&
    other.groupId == groupId &&
    other.conditionTargetOperandDataType == conditionTargetOperandDataType &&
    other.conditionLeftOperand == conditionLeftOperand &&
    other.conditionLeftOperator == conditionLeftOperator &&
    other.conditionRightOperand == conditionRightOperand &&
    other.conditionRightOperator == conditionRightOperator &&
    other.prompt == prompt &&
    other.description == description &&
    other.extractionDataType == extractionDataType;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (question.hashCode) +
    (order.hashCode) +
    (groupId.hashCode) +
    (conditionTargetOperandDataType == null ? 0 : conditionTargetOperandDataType!.hashCode) +
    (conditionLeftOperand == null ? 0 : conditionLeftOperand!.hashCode) +
    (conditionLeftOperator == null ? 0 : conditionLeftOperator!.hashCode) +
    (conditionRightOperand == null ? 0 : conditionRightOperand!.hashCode) +
    (conditionRightOperator == null ? 0 : conditionRightOperator!.hashCode) +
    (prompt.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (extractionDataType.hashCode);

  @override
  String toString() => 'InterviewQuestion[id=$id, question=$question, order=$order, groupId=$groupId, conditionTargetOperandDataType=$conditionTargetOperandDataType, conditionLeftOperand=$conditionLeftOperand, conditionLeftOperator=$conditionLeftOperator, conditionRightOperand=$conditionRightOperand, conditionRightOperator=$conditionRightOperator, prompt=$prompt, description=$description, extractionDataType=$extractionDataType]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'question'] = this.question;
      json[r'order'] = this.order;
      json[r'groupId'] = this.groupId;
    if (this.conditionTargetOperandDataType != null) {
      json[r'conditionTargetOperandDataType'] = this.conditionTargetOperandDataType;
    } else {
      json[r'conditionTargetOperandDataType'] = null;
    }
    if (this.conditionLeftOperand != null) {
      json[r'conditionLeftOperand'] = this.conditionLeftOperand;
    } else {
      json[r'conditionLeftOperand'] = null;
    }
    if (this.conditionLeftOperator != null) {
      json[r'conditionLeftOperator'] = this.conditionLeftOperator;
    } else {
      json[r'conditionLeftOperator'] = null;
    }
    if (this.conditionRightOperand != null) {
      json[r'conditionRightOperand'] = this.conditionRightOperand;
    } else {
      json[r'conditionRightOperand'] = null;
    }
    if (this.conditionRightOperator != null) {
      json[r'conditionRightOperator'] = this.conditionRightOperator;
    } else {
      json[r'conditionRightOperator'] = null;
    }
      json[r'prompt'] = this.prompt;
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
      json[r'extractionDataType'] = this.extractionDataType;
    return json;
  }

  /// Returns a new [InterviewQuestion] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InterviewQuestion? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "InterviewQuestion[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "InterviewQuestion[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return InterviewQuestion(
        id: mapValueOfType<String>(json, r'id')!,
        question: mapValueOfType<String>(json, r'question')!,
        order: mapValueOfType<int>(json, r'order')!,
        groupId: mapValueOfType<String>(json, r'groupId')!,
        conditionTargetOperandDataType: InterviewQuestionConditionTargetOperandDataTypeEnum.fromJson(json[r'conditionTargetOperandDataType']),
        conditionLeftOperand: mapValueOfType<String>(json, r'conditionLeftOperand'),
        conditionLeftOperator: InterviewQuestionConditionLeftOperatorEnum.fromJson(json[r'conditionLeftOperator']),
        conditionRightOperand: mapValueOfType<String>(json, r'conditionRightOperand'),
        conditionRightOperator: InterviewQuestionConditionRightOperatorEnum.fromJson(json[r'conditionRightOperator']),
        prompt: mapValueOfType<String>(json, r'prompt')!,
        description: mapValueOfType<String>(json, r'description'),
        extractionDataType: InterviewQuestionExtractionDataTypeEnum.fromJson(json[r'extractionDataType'])!,
      );
    }
    return null;
  }

  static List<InterviewQuestion> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <InterviewQuestion>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InterviewQuestion.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, InterviewQuestion> mapFromJson(dynamic json) {
    final map = <String, InterviewQuestion>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = InterviewQuestion.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of InterviewQuestion-objects as value to a dart map
  static Map<String, List<InterviewQuestion>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<InterviewQuestion>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = InterviewQuestion.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'question',
    'order',
    'groupId',
    'conditionTargetOperandDataType',
    'conditionLeftOperand',
    'conditionLeftOperator',
    'conditionRightOperand',
    'conditionRightOperator',
    'prompt',
    'description',
    'extractionDataType',
  };
}


class InterviewQuestionConditionTargetOperandDataTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const InterviewQuestionConditionTargetOperandDataTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const int_ = InterviewQuestionConditionTargetOperandDataTypeEnum._(r'int');
  static const float = InterviewQuestionConditionTargetOperandDataTypeEnum._(r'float');
  static const str = InterviewQuestionConditionTargetOperandDataTypeEnum._(r'str');
  static const bool_ = InterviewQuestionConditionTargetOperandDataTypeEnum._(r'bool');

  /// List of all possible values in this [enum][InterviewQuestionConditionTargetOperandDataTypeEnum].
  static const values = <InterviewQuestionConditionTargetOperandDataTypeEnum>[
    int_,
    float,
    str,
    bool_,
  ];

  static InterviewQuestionConditionTargetOperandDataTypeEnum? fromJson(dynamic value) => InterviewQuestionConditionTargetOperandDataTypeEnumTypeTransformer().decode(value);

  static List<InterviewQuestionConditionTargetOperandDataTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <InterviewQuestionConditionTargetOperandDataTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InterviewQuestionConditionTargetOperandDataTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [InterviewQuestionConditionTargetOperandDataTypeEnum] to String,
/// and [decode] dynamic data back to [InterviewQuestionConditionTargetOperandDataTypeEnum].
class InterviewQuestionConditionTargetOperandDataTypeEnumTypeTransformer {
  factory InterviewQuestionConditionTargetOperandDataTypeEnumTypeTransformer() => _instance ??= const InterviewQuestionConditionTargetOperandDataTypeEnumTypeTransformer._();

  const InterviewQuestionConditionTargetOperandDataTypeEnumTypeTransformer._();

  String encode(InterviewQuestionConditionTargetOperandDataTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a InterviewQuestionConditionTargetOperandDataTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  InterviewQuestionConditionTargetOperandDataTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'int': return InterviewQuestionConditionTargetOperandDataTypeEnum.int_;
        case r'float': return InterviewQuestionConditionTargetOperandDataTypeEnum.float;
        case r'str': return InterviewQuestionConditionTargetOperandDataTypeEnum.str;
        case r'bool': return InterviewQuestionConditionTargetOperandDataTypeEnum.bool_;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [InterviewQuestionConditionTargetOperandDataTypeEnumTypeTransformer] instance.
  static InterviewQuestionConditionTargetOperandDataTypeEnumTypeTransformer? _instance;
}



class InterviewQuestionConditionLeftOperatorEnum {
  /// Instantiate a new enum with the provided [value].
  const InterviewQuestionConditionLeftOperatorEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const equalEqual = InterviewQuestionConditionLeftOperatorEnum._(r'==');
  static const greaterThan = InterviewQuestionConditionLeftOperatorEnum._(r'>');
  static const lessThan = InterviewQuestionConditionLeftOperatorEnum._(r'<');
  static const greaterThanEqual = InterviewQuestionConditionLeftOperatorEnum._(r'>=');
  static const lessThanEqual = InterviewQuestionConditionLeftOperatorEnum._(r'<=');
  static const exclamationEqual = InterviewQuestionConditionLeftOperatorEnum._(r'!=');

  /// List of all possible values in this [enum][InterviewQuestionConditionLeftOperatorEnum].
  static const values = <InterviewQuestionConditionLeftOperatorEnum>[
    equalEqual,
    greaterThan,
    lessThan,
    greaterThanEqual,
    lessThanEqual,
    exclamationEqual,
  ];

  static InterviewQuestionConditionLeftOperatorEnum? fromJson(dynamic value) => InterviewQuestionConditionLeftOperatorEnumTypeTransformer().decode(value);

  static List<InterviewQuestionConditionLeftOperatorEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <InterviewQuestionConditionLeftOperatorEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InterviewQuestionConditionLeftOperatorEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [InterviewQuestionConditionLeftOperatorEnum] to String,
/// and [decode] dynamic data back to [InterviewQuestionConditionLeftOperatorEnum].
class InterviewQuestionConditionLeftOperatorEnumTypeTransformer {
  factory InterviewQuestionConditionLeftOperatorEnumTypeTransformer() => _instance ??= const InterviewQuestionConditionLeftOperatorEnumTypeTransformer._();

  const InterviewQuestionConditionLeftOperatorEnumTypeTransformer._();

  String encode(InterviewQuestionConditionLeftOperatorEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a InterviewQuestionConditionLeftOperatorEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  InterviewQuestionConditionLeftOperatorEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'==': return InterviewQuestionConditionLeftOperatorEnum.equalEqual;
        case r'>': return InterviewQuestionConditionLeftOperatorEnum.greaterThan;
        case r'<': return InterviewQuestionConditionLeftOperatorEnum.lessThan;
        case r'>=': return InterviewQuestionConditionLeftOperatorEnum.greaterThanEqual;
        case r'<=': return InterviewQuestionConditionLeftOperatorEnum.lessThanEqual;
        case r'!=': return InterviewQuestionConditionLeftOperatorEnum.exclamationEqual;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [InterviewQuestionConditionLeftOperatorEnumTypeTransformer] instance.
  static InterviewQuestionConditionLeftOperatorEnumTypeTransformer? _instance;
}



class InterviewQuestionConditionRightOperatorEnum {
  /// Instantiate a new enum with the provided [value].
  const InterviewQuestionConditionRightOperatorEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const equalEqual = InterviewQuestionConditionRightOperatorEnum._(r'==');
  static const greaterThan = InterviewQuestionConditionRightOperatorEnum._(r'>');
  static const lessThan = InterviewQuestionConditionRightOperatorEnum._(r'<');
  static const greaterThanEqual = InterviewQuestionConditionRightOperatorEnum._(r'>=');
  static const lessThanEqual = InterviewQuestionConditionRightOperatorEnum._(r'<=');
  static const exclamationEqual = InterviewQuestionConditionRightOperatorEnum._(r'!=');

  /// List of all possible values in this [enum][InterviewQuestionConditionRightOperatorEnum].
  static const values = <InterviewQuestionConditionRightOperatorEnum>[
    equalEqual,
    greaterThan,
    lessThan,
    greaterThanEqual,
    lessThanEqual,
    exclamationEqual,
  ];

  static InterviewQuestionConditionRightOperatorEnum? fromJson(dynamic value) => InterviewQuestionConditionRightOperatorEnumTypeTransformer().decode(value);

  static List<InterviewQuestionConditionRightOperatorEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <InterviewQuestionConditionRightOperatorEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InterviewQuestionConditionRightOperatorEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [InterviewQuestionConditionRightOperatorEnum] to String,
/// and [decode] dynamic data back to [InterviewQuestionConditionRightOperatorEnum].
class InterviewQuestionConditionRightOperatorEnumTypeTransformer {
  factory InterviewQuestionConditionRightOperatorEnumTypeTransformer() => _instance ??= const InterviewQuestionConditionRightOperatorEnumTypeTransformer._();

  const InterviewQuestionConditionRightOperatorEnumTypeTransformer._();

  String encode(InterviewQuestionConditionRightOperatorEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a InterviewQuestionConditionRightOperatorEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  InterviewQuestionConditionRightOperatorEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'==': return InterviewQuestionConditionRightOperatorEnum.equalEqual;
        case r'>': return InterviewQuestionConditionRightOperatorEnum.greaterThan;
        case r'<': return InterviewQuestionConditionRightOperatorEnum.lessThan;
        case r'>=': return InterviewQuestionConditionRightOperatorEnum.greaterThanEqual;
        case r'<=': return InterviewQuestionConditionRightOperatorEnum.lessThanEqual;
        case r'!=': return InterviewQuestionConditionRightOperatorEnum.exclamationEqual;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [InterviewQuestionConditionRightOperatorEnumTypeTransformer] instance.
  static InterviewQuestionConditionRightOperatorEnumTypeTransformer? _instance;
}



class InterviewQuestionExtractionDataTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const InterviewQuestionExtractionDataTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const int_ = InterviewQuestionExtractionDataTypeEnum._(r'int');
  static const float = InterviewQuestionExtractionDataTypeEnum._(r'float');
  static const str = InterviewQuestionExtractionDataTypeEnum._(r'str');
  static const bool_ = InterviewQuestionExtractionDataTypeEnum._(r'bool');

  /// List of all possible values in this [enum][InterviewQuestionExtractionDataTypeEnum].
  static const values = <InterviewQuestionExtractionDataTypeEnum>[
    int_,
    float,
    str,
    bool_,
  ];

  static InterviewQuestionExtractionDataTypeEnum? fromJson(dynamic value) => InterviewQuestionExtractionDataTypeEnumTypeTransformer().decode(value);

  static List<InterviewQuestionExtractionDataTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <InterviewQuestionExtractionDataTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InterviewQuestionExtractionDataTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [InterviewQuestionExtractionDataTypeEnum] to String,
/// and [decode] dynamic data back to [InterviewQuestionExtractionDataTypeEnum].
class InterviewQuestionExtractionDataTypeEnumTypeTransformer {
  factory InterviewQuestionExtractionDataTypeEnumTypeTransformer() => _instance ??= const InterviewQuestionExtractionDataTypeEnumTypeTransformer._();

  const InterviewQuestionExtractionDataTypeEnumTypeTransformer._();

  String encode(InterviewQuestionExtractionDataTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a InterviewQuestionExtractionDataTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  InterviewQuestionExtractionDataTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'int': return InterviewQuestionExtractionDataTypeEnum.int_;
        case r'float': return InterviewQuestionExtractionDataTypeEnum.float;
        case r'str': return InterviewQuestionExtractionDataTypeEnum.str;
        case r'bool': return InterviewQuestionExtractionDataTypeEnum.bool_;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [InterviewQuestionExtractionDataTypeEnumTypeTransformer] instance.
  static InterviewQuestionExtractionDataTypeEnumTypeTransformer? _instance;
}


