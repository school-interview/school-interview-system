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
  /// アバターのセリフ
  String get avatarSpeech => throw _privateConstructorUsedError;

  /// ユーザーのセリフ
  String get userSpeech => throw _privateConstructorUsedError;

  /// ユーザーが話しているかどうかを判別する
  bool get isTalking => throw _privateConstructorUsedError;

  /// 面談開始レスポンス
  StartInterviewResponse? get startInterviewResponse =>
      throw _privateConstructorUsedError;

  /// API処理結果
  Result? get result => throw _privateConstructorUsedError;

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
      {String avatarSpeech,
      String userSpeech,
      bool isTalking,
      StartInterviewResponse? startInterviewResponse,
      Result? result});
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
    Object? avatarSpeech = null,
    Object? userSpeech = null,
    Object? isTalking = null,
    Object? startInterviewResponse = freezed,
    Object? result = freezed,
  }) {
    return _then(_value.copyWith(
      avatarSpeech: null == avatarSpeech
          ? _value.avatarSpeech
          : avatarSpeech // ignore: cast_nullable_to_non_nullable
              as String,
      userSpeech: null == userSpeech
          ? _value.userSpeech
          : userSpeech // ignore: cast_nullable_to_non_nullable
              as String,
      isTalking: null == isTalking
          ? _value.isTalking
          : isTalking // ignore: cast_nullable_to_non_nullable
              as bool,
      startInterviewResponse: freezed == startInterviewResponse
          ? _value.startInterviewResponse
          : startInterviewResponse // ignore: cast_nullable_to_non_nullable
              as StartInterviewResponse?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
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
      {String avatarSpeech,
      String userSpeech,
      bool isTalking,
      StartInterviewResponse? startInterviewResponse,
      Result? result});
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
    Object? avatarSpeech = null,
    Object? userSpeech = null,
    Object? isTalking = null,
    Object? startInterviewResponse = freezed,
    Object? result = freezed,
  }) {
    return _then(_$InterviewViewStateImpl(
      avatarSpeech: null == avatarSpeech
          ? _value.avatarSpeech
          : avatarSpeech // ignore: cast_nullable_to_non_nullable
              as String,
      userSpeech: null == userSpeech
          ? _value.userSpeech
          : userSpeech // ignore: cast_nullable_to_non_nullable
              as String,
      isTalking: null == isTalking
          ? _value.isTalking
          : isTalking // ignore: cast_nullable_to_non_nullable
              as bool,
      startInterviewResponse: freezed == startInterviewResponse
          ? _value.startInterviewResponse
          : startInterviewResponse // ignore: cast_nullable_to_non_nullable
              as StartInterviewResponse?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
    ));
  }
}

/// @nodoc

class _$InterviewViewStateImpl implements _InterviewViewState {
  const _$InterviewViewStateImpl(
      {this.avatarSpeech = "",
      this.userSpeech = "",
      this.isTalking = false,
      this.startInterviewResponse,
      this.result});

  /// アバターのセリフ
  @override
  @JsonKey()
  final String avatarSpeech;

  /// ユーザーのセリフ
  @override
  @JsonKey()
  final String userSpeech;

  /// ユーザーが話しているかどうかを判別する
  @override
  @JsonKey()
  final bool isTalking;

  /// 面談開始レスポンス
  @override
  final StartInterviewResponse? startInterviewResponse;

  /// API処理結果
  @override
  final Result? result;

  @override
  String toString() {
    return 'InterviewViewState(avatarSpeech: $avatarSpeech, userSpeech: $userSpeech, isTalking: $isTalking, startInterviewResponse: $startInterviewResponse, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterviewViewStateImpl &&
            (identical(other.avatarSpeech, avatarSpeech) ||
                other.avatarSpeech == avatarSpeech) &&
            (identical(other.userSpeech, userSpeech) ||
                other.userSpeech == userSpeech) &&
            (identical(other.isTalking, isTalking) ||
                other.isTalking == isTalking) &&
            (identical(other.startInterviewResponse, startInterviewResponse) ||
                other.startInterviewResponse == startInterviewResponse) &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, avatarSpeech, userSpeech,
      isTalking, startInterviewResponse, result);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InterviewViewStateImplCopyWith<_$InterviewViewStateImpl> get copyWith =>
      __$$InterviewViewStateImplCopyWithImpl<_$InterviewViewStateImpl>(
          this, _$identity);
}

abstract class _InterviewViewState implements InterviewViewState {
  const factory _InterviewViewState(
      {final String avatarSpeech,
      final String userSpeech,
      final bool isTalking,
      final StartInterviewResponse? startInterviewResponse,
      final Result? result}) = _$InterviewViewStateImpl;

  @override

  /// アバターのセリフ
  String get avatarSpeech;
  @override

  /// ユーザーのセリフ
  String get userSpeech;
  @override

  /// ユーザーが話しているかどうかを判別する
  bool get isTalking;
  @override

  /// 面談開始レスポンス
  StartInterviewResponse? get startInterviewResponse;
  @override

  /// API処理結果
  Result? get result;
  @override
  @JsonKey(ignore: true)
  _$$InterviewViewStateImplCopyWith<_$InterviewViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
