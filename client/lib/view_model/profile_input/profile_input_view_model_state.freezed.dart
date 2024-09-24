// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_input_view_model_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileInputViewModelState {
  String get name => throw _privateConstructorUsedError;
  int get semester => throw _privateConstructorUsedError;
  dynamic get department => throw _privateConstructorUsedError;
  String get schoolNumber => throw _privateConstructorUsedError;
  String get classColmunNumber => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileInputViewModelStateCopyWith<ProfileInputViewModelState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileInputViewModelStateCopyWith<$Res> {
  factory $ProfileInputViewModelStateCopyWith(ProfileInputViewModelState value,
          $Res Function(ProfileInputViewModelState) then) =
      _$ProfileInputViewModelStateCopyWithImpl<$Res,
          ProfileInputViewModelState>;
  @useResult
  $Res call(
      {String name,
      int semester,
      dynamic department,
      String schoolNumber,
      String classColmunNumber});
}

/// @nodoc
class _$ProfileInputViewModelStateCopyWithImpl<$Res,
        $Val extends ProfileInputViewModelState>
    implements $ProfileInputViewModelStateCopyWith<$Res> {
  _$ProfileInputViewModelStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? semester = null,
    Object? department = freezed,
    Object? schoolNumber = null,
    Object? classColmunNumber = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      semester: null == semester
          ? _value.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as int,
      department: freezed == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as dynamic,
      schoolNumber: null == schoolNumber
          ? _value.schoolNumber
          : schoolNumber // ignore: cast_nullable_to_non_nullable
              as String,
      classColmunNumber: null == classColmunNumber
          ? _value.classColmunNumber
          : classColmunNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileInputViewModelStateImplCopyWith<$Res>
    implements $ProfileInputViewModelStateCopyWith<$Res> {
  factory _$$ProfileInputViewModelStateImplCopyWith(
          _$ProfileInputViewModelStateImpl value,
          $Res Function(_$ProfileInputViewModelStateImpl) then) =
      __$$ProfileInputViewModelStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      int semester,
      dynamic department,
      String schoolNumber,
      String classColmunNumber});
}

/// @nodoc
class __$$ProfileInputViewModelStateImplCopyWithImpl<$Res>
    extends _$ProfileInputViewModelStateCopyWithImpl<$Res,
        _$ProfileInputViewModelStateImpl>
    implements _$$ProfileInputViewModelStateImplCopyWith<$Res> {
  __$$ProfileInputViewModelStateImplCopyWithImpl(
      _$ProfileInputViewModelStateImpl _value,
      $Res Function(_$ProfileInputViewModelStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? semester = null,
    Object? department = freezed,
    Object? schoolNumber = null,
    Object? classColmunNumber = null,
  }) {
    return _then(_$ProfileInputViewModelStateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      semester: null == semester
          ? _value.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as int,
      department: freezed == department ? _value.department! : department,
      schoolNumber: null == schoolNumber
          ? _value.schoolNumber
          : schoolNumber // ignore: cast_nullable_to_non_nullable
              as String,
      classColmunNumber: null == classColmunNumber
          ? _value.classColmunNumber
          : classColmunNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProfileInputViewModelStateImpl implements _ProfileInputViewModelState {
  const _$ProfileInputViewModelStateImpl(
      {this.name = "",
      this.semester = 1,
      this.department = "",
      this.schoolNumber = "",
      this.classColmunNumber = ""});

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final int semester;
  @override
  @JsonKey()
  final dynamic department;
  @override
  @JsonKey()
  final String schoolNumber;
  @override
  @JsonKey()
  final String classColmunNumber;

  @override
  String toString() {
    return 'ProfileInputViewModelState(name: $name, semester: $semester, department: $department, schoolNumber: $schoolNumber, classColmunNumber: $classColmunNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileInputViewModelStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.semester, semester) ||
                other.semester == semester) &&
            const DeepCollectionEquality()
                .equals(other.department, department) &&
            (identical(other.schoolNumber, schoolNumber) ||
                other.schoolNumber == schoolNumber) &&
            (identical(other.classColmunNumber, classColmunNumber) ||
                other.classColmunNumber == classColmunNumber));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      semester,
      const DeepCollectionEquality().hash(department),
      schoolNumber,
      classColmunNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileInputViewModelStateImplCopyWith<_$ProfileInputViewModelStateImpl>
      get copyWith => __$$ProfileInputViewModelStateImplCopyWithImpl<
          _$ProfileInputViewModelStateImpl>(this, _$identity);
}

abstract class _ProfileInputViewModelState
    implements ProfileInputViewModelState {
  const factory _ProfileInputViewModelState(
      {final String name,
      final int semester,
      final dynamic department,
      final String schoolNumber,
      final String classColmunNumber}) = _$ProfileInputViewModelStateImpl;

  @override
  String get name;
  @override
  int get semester;
  @override
  dynamic get department;
  @override
  String get schoolNumber;
  @override
  String get classColmunNumber;
  @override
  @JsonKey(ignore: true)
  _$$ProfileInputViewModelStateImplCopyWith<_$ProfileInputViewModelStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
