// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interview_analytics_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InterviewAnalyticsViewState {
  /// アニメーションが動いたかどうかを判別する
  bool get isAnimated => throw _privateConstructorUsedError;

  /// Create a copy of InterviewAnalyticsViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InterviewAnalyticsViewStateCopyWith<InterviewAnalyticsViewState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterviewAnalyticsViewStateCopyWith<$Res> {
  factory $InterviewAnalyticsViewStateCopyWith(
          InterviewAnalyticsViewState value,
          $Res Function(InterviewAnalyticsViewState) then) =
      _$InterviewAnalyticsViewStateCopyWithImpl<$Res,
          InterviewAnalyticsViewState>;
  @useResult
  $Res call({bool isAnimated});
}

/// @nodoc
class _$InterviewAnalyticsViewStateCopyWithImpl<$Res,
        $Val extends InterviewAnalyticsViewState>
    implements $InterviewAnalyticsViewStateCopyWith<$Res> {
  _$InterviewAnalyticsViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InterviewAnalyticsViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAnimated = null,
  }) {
    return _then(_value.copyWith(
      isAnimated: null == isAnimated
          ? _value.isAnimated
          : isAnimated // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InterviewAnalyticsViewStateImplCopyWith<$Res>
    implements $InterviewAnalyticsViewStateCopyWith<$Res> {
  factory _$$InterviewAnalyticsViewStateImplCopyWith(
          _$InterviewAnalyticsViewStateImpl value,
          $Res Function(_$InterviewAnalyticsViewStateImpl) then) =
      __$$InterviewAnalyticsViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isAnimated});
}

/// @nodoc
class __$$InterviewAnalyticsViewStateImplCopyWithImpl<$Res>
    extends _$InterviewAnalyticsViewStateCopyWithImpl<$Res,
        _$InterviewAnalyticsViewStateImpl>
    implements _$$InterviewAnalyticsViewStateImplCopyWith<$Res> {
  __$$InterviewAnalyticsViewStateImplCopyWithImpl(
      _$InterviewAnalyticsViewStateImpl _value,
      $Res Function(_$InterviewAnalyticsViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of InterviewAnalyticsViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAnimated = null,
  }) {
    return _then(_$InterviewAnalyticsViewStateImpl(
      isAnimated: null == isAnimated
          ? _value.isAnimated
          : isAnimated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$InterviewAnalyticsViewStateImpl
    implements _InterviewAnalyticsViewState {
  const _$InterviewAnalyticsViewStateImpl({this.isAnimated = false});

  /// アニメーションが動いたかどうかを判別する
  @override
  @JsonKey()
  final bool isAnimated;

  @override
  String toString() {
    return 'InterviewAnalyticsViewState(isAnimated: $isAnimated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterviewAnalyticsViewStateImpl &&
            (identical(other.isAnimated, isAnimated) ||
                other.isAnimated == isAnimated));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isAnimated);

  /// Create a copy of InterviewAnalyticsViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InterviewAnalyticsViewStateImplCopyWith<_$InterviewAnalyticsViewStateImpl>
      get copyWith => __$$InterviewAnalyticsViewStateImplCopyWithImpl<
          _$InterviewAnalyticsViewStateImpl>(this, _$identity);
}

abstract class _InterviewAnalyticsViewState
    implements InterviewAnalyticsViewState {
  const factory _InterviewAnalyticsViewState({final bool isAnimated}) =
      _$InterviewAnalyticsViewStateImpl;

  /// アニメーションが動いたかどうかを判別する
  @override
  bool get isAnimated;

  /// Create a copy of InterviewAnalyticsViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InterviewAnalyticsViewStateImplCopyWith<_$InterviewAnalyticsViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
