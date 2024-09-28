// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interview_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InterviewViewState {
  /// API処理結果
  Result? get result => throw _privateConstructorUsedError;

  /// ローディング中かどうかを判別する
  bool get isLoading => throw _privateConstructorUsedError;

  /// アバターのセリフ
  String get avatarMessage => throw _privateConstructorUsedError;

  /// ユーザーのセリフ
  String get userMessage => throw _privateConstructorUsedError;

  /// 誰が話しているかを判別する
  WhoTalking get whoTalking => throw _privateConstructorUsedError;

  /// 最新のinterviewSessionId
  String get currentInterviewSessionId => throw _privateConstructorUsedError;

  /// Create a copy of InterviewViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InterviewViewStateCopyWith<InterviewViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterviewViewStateCopyWith<$Res> {
  factory $InterviewViewStateCopyWith(
          InterviewViewState value, $Res Function(InterviewViewState) then) =
      _$InterviewViewStateCopyWithImpl<$Res, InterviewViewState>;
  @useResult
  $Res call(
      {Result? result,
      bool isLoading,
      String avatarMessage,
      String userMessage,
      WhoTalking whoTalking,
      String currentInterviewSessionId});
}

/// @nodoc
class _$InterviewViewStateCopyWithImpl<$Res, $Val extends InterviewViewState>
    implements $InterviewViewStateCopyWith<$Res> {
  _$InterviewViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InterviewViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? isLoading = null,
    Object? avatarMessage = null,
    Object? userMessage = null,
    Object? whoTalking = null,
    Object? currentInterviewSessionId = null,
  }) {
    return _then(_value.copyWith(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      avatarMessage: null == avatarMessage
          ? _value.avatarMessage
          : avatarMessage // ignore: cast_nullable_to_non_nullable
              as String,
      userMessage: null == userMessage
          ? _value.userMessage
          : userMessage // ignore: cast_nullable_to_non_nullable
              as String,
      whoTalking: null == whoTalking
          ? _value.whoTalking
          : whoTalking // ignore: cast_nullable_to_non_nullable
              as WhoTalking,
      currentInterviewSessionId: null == currentInterviewSessionId
          ? _value.currentInterviewSessionId
          : currentInterviewSessionId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InterviewViewStateImplCopyWith<$Res>
    implements $InterviewViewStateCopyWith<$Res> {
  factory _$$InterviewViewStateImplCopyWith(_$InterviewViewStateImpl value,
          $Res Function(_$InterviewViewStateImpl) then) =
      __$$InterviewViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Result? result,
      bool isLoading,
      String avatarMessage,
      String userMessage,
      WhoTalking whoTalking,
      String currentInterviewSessionId});
}

/// @nodoc
class __$$InterviewViewStateImplCopyWithImpl<$Res>
    extends _$InterviewViewStateCopyWithImpl<$Res, _$InterviewViewStateImpl>
    implements _$$InterviewViewStateImplCopyWith<$Res> {
  __$$InterviewViewStateImplCopyWithImpl(_$InterviewViewStateImpl _value,
      $Res Function(_$InterviewViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of InterviewViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? isLoading = null,
    Object? avatarMessage = null,
    Object? userMessage = null,
    Object? whoTalking = null,
    Object? currentInterviewSessionId = null,
  }) {
    return _then(_$InterviewViewStateImpl(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      avatarMessage: null == avatarMessage
          ? _value.avatarMessage
          : avatarMessage // ignore: cast_nullable_to_non_nullable
              as String,
      userMessage: null == userMessage
          ? _value.userMessage
          : userMessage // ignore: cast_nullable_to_non_nullable
              as String,
      whoTalking: null == whoTalking
          ? _value.whoTalking
          : whoTalking // ignore: cast_nullable_to_non_nullable
              as WhoTalking,
      currentInterviewSessionId: null == currentInterviewSessionId
          ? _value.currentInterviewSessionId
          : currentInterviewSessionId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InterviewViewStateImpl implements _InterviewViewState {
  const _$InterviewViewStateImpl(
      {this.result,
      this.isLoading = true,
      this.avatarMessage = "",
      this.userMessage = "",
      this.whoTalking = WhoTalking.none,
      this.currentInterviewSessionId = ""});

  /// API処理結果
  @override
  final Result? result;

  /// ローディング中かどうかを判別する
  @override
  @JsonKey()
  final bool isLoading;

  /// アバターのセリフ
  @override
  @JsonKey()
  final String avatarMessage;

  /// ユーザーのセリフ
  @override
  @JsonKey()
  final String userMessage;

  /// 誰が話しているかを判別する
  @override
  @JsonKey()
  final WhoTalking whoTalking;

  /// 最新のinterviewSessionId
  @override
  @JsonKey()
  final String currentInterviewSessionId;

  @override
  String toString() {
    return 'InterviewViewState(result: $result, isLoading: $isLoading, avatarMessage: $avatarMessage, userMessage: $userMessage, whoTalking: $whoTalking, currentInterviewSessionId: $currentInterviewSessionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterviewViewStateImpl &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.avatarMessage, avatarMessage) ||
                other.avatarMessage == avatarMessage) &&
            (identical(other.userMessage, userMessage) ||
                other.userMessage == userMessage) &&
            (identical(other.whoTalking, whoTalking) ||
                other.whoTalking == whoTalking) &&
            (identical(other.currentInterviewSessionId,
                    currentInterviewSessionId) ||
                other.currentInterviewSessionId == currentInterviewSessionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result, isLoading, avatarMessage,
      userMessage, whoTalking, currentInterviewSessionId);

  /// Create a copy of InterviewViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InterviewViewStateImplCopyWith<_$InterviewViewStateImpl> get copyWith =>
      __$$InterviewViewStateImplCopyWithImpl<_$InterviewViewStateImpl>(
          this, _$identity);
}

abstract class _InterviewViewState implements InterviewViewState {
  const factory _InterviewViewState(
      {final Result? result,
      final bool isLoading,
      final String avatarMessage,
      final String userMessage,
      final WhoTalking whoTalking,
      final String currentInterviewSessionId}) = _$InterviewViewStateImpl;

  /// API処理結果
  @override
  Result? get result;

  /// ローディング中かどうかを判別する
  @override
  bool get isLoading;

  /// アバターのセリフ
  @override
  String get avatarMessage;

  /// ユーザーのセリフ
  @override
  String get userMessage;

  /// 誰が話しているかを判別する
  @override
  WhoTalking get whoTalking;

  /// 最新のinterviewSessionId
  @override
  String get currentInterviewSessionId;

  /// Create a copy of InterviewViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InterviewViewStateImplCopyWith<_$InterviewViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
