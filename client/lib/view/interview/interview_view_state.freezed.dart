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

  /// 面談結果
  InterviewAnalytics? get interviewAnalytics =>
      throw _privateConstructorUsedError;

  /// 面談が終了したかどうかを判別する
  bool get isFinishInterview => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
      String currentInterviewSessionId,
      InterviewAnalytics? interviewAnalytics,
      bool isFinishInterview});
}

/// @nodoc
class _$InterviewViewStateCopyWithImpl<$Res, $Val extends InterviewViewState>
    implements $InterviewViewStateCopyWith<$Res> {
  _$InterviewViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? isLoading = null,
    Object? avatarMessage = null,
    Object? userMessage = null,
    Object? whoTalking = null,
    Object? currentInterviewSessionId = null,
    Object? interviewAnalytics = freezed,
    Object? isFinishInterview = null,
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
      interviewAnalytics: freezed == interviewAnalytics
          ? _value.interviewAnalytics
          : interviewAnalytics // ignore: cast_nullable_to_non_nullable
              as InterviewAnalytics?,
      isFinishInterview: null == isFinishInterview
          ? _value.isFinishInterview
          : isFinishInterview // ignore: cast_nullable_to_non_nullable
              as bool,
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
      String currentInterviewSessionId,
      InterviewAnalytics? interviewAnalytics,
      bool isFinishInterview});
}

/// @nodoc
class __$$InterviewViewStateImplCopyWithImpl<$Res>
    extends _$InterviewViewStateCopyWithImpl<$Res, _$InterviewViewStateImpl>
    implements _$$InterviewViewStateImplCopyWith<$Res> {
  __$$InterviewViewStateImplCopyWithImpl(_$InterviewViewStateImpl _value,
      $Res Function(_$InterviewViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? isLoading = null,
    Object? avatarMessage = null,
    Object? userMessage = null,
    Object? whoTalking = null,
    Object? currentInterviewSessionId = null,
    Object? interviewAnalytics = freezed,
    Object? isFinishInterview = null,
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
      interviewAnalytics: freezed == interviewAnalytics
          ? _value.interviewAnalytics
          : interviewAnalytics // ignore: cast_nullable_to_non_nullable
              as InterviewAnalytics?,
      isFinishInterview: null == isFinishInterview
          ? _value.isFinishInterview
          : isFinishInterview // ignore: cast_nullable_to_non_nullable
              as bool,
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
      this.currentInterviewSessionId = "",
      this.interviewAnalytics,
      this.isFinishInterview = false});

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

  /// 面談結果
  @override
  final InterviewAnalytics? interviewAnalytics;

  /// 面談が終了したかどうかを判別する
  @override
  @JsonKey()
  final bool isFinishInterview;

  @override
  String toString() {
    return 'InterviewViewState(result: $result, isLoading: $isLoading, avatarMessage: $avatarMessage, userMessage: $userMessage, whoTalking: $whoTalking, currentInterviewSessionId: $currentInterviewSessionId, interviewAnalytics: $interviewAnalytics, isFinishInterview: $isFinishInterview)';
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
                other.currentInterviewSessionId == currentInterviewSessionId) &&
            (identical(other.interviewAnalytics, interviewAnalytics) ||
                other.interviewAnalytics == interviewAnalytics) &&
            (identical(other.isFinishInterview, isFinishInterview) ||
                other.isFinishInterview == isFinishInterview));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      result,
      isLoading,
      avatarMessage,
      userMessage,
      whoTalking,
      currentInterviewSessionId,
      interviewAnalytics,
      isFinishInterview);

  @JsonKey(ignore: true)
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
      final String currentInterviewSessionId,
      final InterviewAnalytics? interviewAnalytics,
      final bool isFinishInterview}) = _$InterviewViewStateImpl;

  @override

  /// API処理結果
  Result? get result;
  @override

  /// ローディング中かどうかを判別する
  bool get isLoading;
  @override

  /// アバターのセリフ
  String get avatarMessage;
  @override

  /// ユーザーのセリフ
  String get userMessage;
  @override

  /// 誰が話しているかを判別する
  WhoTalking get whoTalking;
  @override

  /// 最新のinterviewSessionId
  String get currentInterviewSessionId;
  @override

  /// 面談結果
  InterviewAnalytics? get interviewAnalytics;
  @override

  /// 面談が終了したかどうかを判別する
  bool get isFinishInterview;
  @override
  @JsonKey(ignore: true)
  _$$InterviewViewStateImplCopyWith<_$InterviewViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
