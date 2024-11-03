// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_input_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileInputViewState {
  /// API処理結果
  Result? get result => throw _privateConstructorUsedError;

  /// 学籍番号
  String get studentId => throw _privateConstructorUsedError;

  /// 氏名
  String get name => throw _privateConstructorUsedError;

  /// 学科
  String get department => throw _privateConstructorUsedError;

  /// 学期（前学期か後学期）
  int get semester => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileInputViewStateCopyWith<ProfileInputViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileInputViewStateCopyWith<$Res> {
  factory $ProfileInputViewStateCopyWith(ProfileInputViewState value,
          $Res Function(ProfileInputViewState) then) =
      _$ProfileInputViewStateCopyWithImpl<$Res, ProfileInputViewState>;
  @useResult
  $Res call(
      {Result? result,
      String studentId,
      String name,
      String department,
      int semester});
}

/// @nodoc
class _$ProfileInputViewStateCopyWithImpl<$Res,
        $Val extends ProfileInputViewState>
    implements $ProfileInputViewStateCopyWith<$Res> {
  _$ProfileInputViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? studentId = null,
    Object? name = null,
    Object? department = null,
    Object? semester = null,
  }) {
    return _then(_value.copyWith(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      semester: null == semester
          ? _value.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileInputViewStateImplCopyWith<$Res>
    implements $ProfileInputViewStateCopyWith<$Res> {
  factory _$$ProfileInputViewStateImplCopyWith(
          _$ProfileInputViewStateImpl value,
          $Res Function(_$ProfileInputViewStateImpl) then) =
      __$$ProfileInputViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Result? result,
      String studentId,
      String name,
      String department,
      int semester});
}

/// @nodoc
class __$$ProfileInputViewStateImplCopyWithImpl<$Res>
    extends _$ProfileInputViewStateCopyWithImpl<$Res,
        _$ProfileInputViewStateImpl>
    implements _$$ProfileInputViewStateImplCopyWith<$Res> {
  __$$ProfileInputViewStateImplCopyWithImpl(_$ProfileInputViewStateImpl _value,
      $Res Function(_$ProfileInputViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? studentId = null,
    Object? name = null,
    Object? department = null,
    Object? semester = null,
  }) {
    return _then(_$ProfileInputViewStateImpl(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      semester: null == semester
          ? _value.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ProfileInputViewStateImpl implements _ProfileInputViewState {
  const _$ProfileInputViewStateImpl(
      {this.result,
      this.studentId = "",
      this.name = "",
      this.department = "",
      this.semester = 1});

  /// API処理結果
  @override
  final Result? result;

  /// 学籍番号
  @override
  @JsonKey()
  final String studentId;

  /// 氏名
  @override
  @JsonKey()
  final String name;

  /// 学科
  @override
  @JsonKey()
  final String department;

  /// 学期（前学期か後学期）
  @override
  @JsonKey()
  final int semester;

  @override
  String toString() {
    return 'ProfileInputViewState(result: $result, studentId: $studentId, name: $name, department: $department, semester: $semester)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileInputViewStateImpl &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.semester, semester) ||
                other.semester == semester));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, result, studentId, name, department, semester);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileInputViewStateImplCopyWith<_$ProfileInputViewStateImpl>
      get copyWith => __$$ProfileInputViewStateImplCopyWithImpl<
          _$ProfileInputViewStateImpl>(this, _$identity);
}

abstract class _ProfileInputViewState implements ProfileInputViewState {
  const factory _ProfileInputViewState(
      {final Result? result,
      final String studentId,
      final String name,
      final String department,
      final int semester}) = _$ProfileInputViewStateImpl;

  @override

  /// API処理結果
  Result? get result;
  @override

  /// 学籍番号
  String get studentId;
  @override

  /// 氏名
  String get name;
  @override

  /// 学科
  String get department;
  @override

  /// 学期（前学期か後学期）
  int get semester;
  @override
  @JsonKey(ignore: true)
  _$$ProfileInputViewStateImplCopyWith<_$ProfileInputViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
