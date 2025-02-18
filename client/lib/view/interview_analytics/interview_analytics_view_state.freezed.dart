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
  bool get isAnimated => throw _privateConstructorUsedError; // TODO 実験が終わったら削除
  bool get isCopied => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
  $Res call({bool isAnimated, bool isCopied});
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAnimated = null,
    Object? isCopied = null,
  }) {
    return _then(_value.copyWith(
      isAnimated: null == isAnimated
          ? _value.isAnimated
          : isAnimated // ignore: cast_nullable_to_non_nullable
              as bool,
      isCopied: null == isCopied
          ? _value.isCopied
          : isCopied // ignore: cast_nullable_to_non_nullable
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
  $Res call({bool isAnimated, bool isCopied});
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAnimated = null,
    Object? isCopied = null,
  }) {
    return _then(_$InterviewAnalyticsViewStateImpl(
      isAnimated: null == isAnimated
          ? _value.isAnimated
          : isAnimated // ignore: cast_nullable_to_non_nullable
              as bool,
      isCopied: null == isCopied
          ? _value.isCopied
          : isCopied // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$InterviewAnalyticsViewStateImpl
    implements _InterviewAnalyticsViewState {
  const _$InterviewAnalyticsViewStateImpl(
      {this.isAnimated = false, this.isCopied = false});

  /// アニメーションが動いたかどうかを判別する
  @override
  @JsonKey()
  final bool isAnimated;
// TODO 実験が終わったら削除
  @override
  @JsonKey()
  final bool isCopied;

  @override
  String toString() {
    return 'InterviewAnalyticsViewState(isAnimated: $isAnimated, isCopied: $isCopied)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterviewAnalyticsViewStateImpl &&
            (identical(other.isAnimated, isAnimated) ||
                other.isAnimated == isAnimated) &&
            (identical(other.isCopied, isCopied) ||
                other.isCopied == isCopied));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isAnimated, isCopied);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InterviewAnalyticsViewStateImplCopyWith<_$InterviewAnalyticsViewStateImpl>
      get copyWith => __$$InterviewAnalyticsViewStateImplCopyWithImpl<
          _$InterviewAnalyticsViewStateImpl>(this, _$identity);
}

abstract class _InterviewAnalyticsViewState
    implements InterviewAnalyticsViewState {
  const factory _InterviewAnalyticsViewState(
      {final bool isAnimated,
      final bool isCopied}) = _$InterviewAnalyticsViewStateImpl;

  @override

  /// アニメーションが動いたかどうかを判別する
  bool get isAnimated;
  @override // TODO 実験が終わったら削除
  bool get isCopied;
  @override
  @JsonKey(ignore: true)
  _$$InterviewAnalyticsViewStateImplCopyWith<_$InterviewAnalyticsViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
