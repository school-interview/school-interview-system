// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'start_view_model_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StartViewModelState {
  String get name => throw _privateConstructorUsedError;
  String get schoolNumber => throw _privateConstructorUsedError;
  String get classColmunNumber => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StartViewModelStateCopyWith<StartViewModelState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StartViewModelStateCopyWith<$Res> {
  factory $StartViewModelStateCopyWith(
          StartViewModelState value, $Res Function(StartViewModelState) then) =
      _$StartViewModelStateCopyWithImpl<$Res, StartViewModelState>;
  @useResult
  $Res call({String name, String schoolNumber, String classColmunNumber});
}

/// @nodoc
class _$StartViewModelStateCopyWithImpl<$Res, $Val extends StartViewModelState>
    implements $StartViewModelStateCopyWith<$Res> {
  _$StartViewModelStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? schoolNumber = null,
    Object? classColmunNumber = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$StartViewModelStateImplCopyWith<$Res>
    implements $StartViewModelStateCopyWith<$Res> {
  factory _$$StartViewModelStateImplCopyWith(_$StartViewModelStateImpl value,
          $Res Function(_$StartViewModelStateImpl) then) =
      __$$StartViewModelStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String schoolNumber, String classColmunNumber});
}

/// @nodoc
class __$$StartViewModelStateImplCopyWithImpl<$Res>
    extends _$StartViewModelStateCopyWithImpl<$Res, _$StartViewModelStateImpl>
    implements _$$StartViewModelStateImplCopyWith<$Res> {
  __$$StartViewModelStateImplCopyWithImpl(_$StartViewModelStateImpl _value,
      $Res Function(_$StartViewModelStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? schoolNumber = null,
    Object? classColmunNumber = null,
  }) {
    return _then(_$StartViewModelStateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
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

class _$StartViewModelStateImpl implements _StartViewModelState {
  const _$StartViewModelStateImpl(
      {this.name = "", this.schoolNumber = "", this.classColmunNumber = ""});

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String schoolNumber;
  @override
  @JsonKey()
  final String classColmunNumber;

  @override
  String toString() {
    return 'StartViewModelState(name: $name, schoolNumber: $schoolNumber, classColmunNumber: $classColmunNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartViewModelStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.schoolNumber, schoolNumber) ||
                other.schoolNumber == schoolNumber) &&
            (identical(other.classColmunNumber, classColmunNumber) ||
                other.classColmunNumber == classColmunNumber));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, schoolNumber, classColmunNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StartViewModelStateImplCopyWith<_$StartViewModelStateImpl> get copyWith =>
      __$$StartViewModelStateImplCopyWithImpl<_$StartViewModelStateImpl>(
          this, _$identity);
}

abstract class _StartViewModelState implements StartViewModelState {
  const factory _StartViewModelState(
      {final String name,
      final String schoolNumber,
      final String classColmunNumber}) = _$StartViewModelStateImpl;

  @override
  String get name;
  @override
  String get schoolNumber;
  @override
  String get classColmunNumber;
  @override
  @JsonKey(ignore: true)
  _$$StartViewModelStateImplCopyWith<_$StartViewModelStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
