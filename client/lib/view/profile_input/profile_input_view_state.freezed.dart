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
  $Res call({Result? result});
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
  }) {
    return _then(_value.copyWith(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
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
  $Res call({Result? result});
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
  }) {
    return _then(_$ProfileInputViewStateImpl(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
    ));
  }
}

/// @nodoc

class _$ProfileInputViewStateImpl implements _ProfileInputViewState {
  const _$ProfileInputViewStateImpl({this.result});

  /// API処理結果
  @override
  final Result? result;

  @override
  String toString() {
    return 'ProfileInputViewState(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileInputViewStateImpl &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileInputViewStateImplCopyWith<_$ProfileInputViewStateImpl>
      get copyWith => __$$ProfileInputViewStateImplCopyWithImpl<
          _$ProfileInputViewStateImpl>(this, _$identity);
}

abstract class _ProfileInputViewState implements ProfileInputViewState {
  const factory _ProfileInputViewState({final Result? result}) =
      _$ProfileInputViewStateImpl;

  @override

  /// API処理結果
  Result? get result;
  @override
  @JsonKey(ignore: true)
  _$$ProfileInputViewStateImplCopyWith<_$ProfileInputViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
