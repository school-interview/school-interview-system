// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interview_report_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InterviewReportState {
  /// API処理結果
  Result? get result => throw _privateConstructorUsedError;

  /// 面談結果一覧
  InterviewReportsResponse? get interviewReport =>
      throw _privateConstructorUsedError;

  /// Create a copy of InterviewReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InterviewReportStateCopyWith<InterviewReportState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterviewReportStateCopyWith<$Res> {
  factory $InterviewReportStateCopyWith(InterviewReportState value,
          $Res Function(InterviewReportState) then) =
      _$InterviewReportStateCopyWithImpl<$Res, InterviewReportState>;
  @useResult
  $Res call({Result? result, InterviewReportsResponse? interviewReport});
}

/// @nodoc
class _$InterviewReportStateCopyWithImpl<$Res,
        $Val extends InterviewReportState>
    implements $InterviewReportStateCopyWith<$Res> {
  _$InterviewReportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InterviewReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? interviewReport = freezed,
  }) {
    return _then(_value.copyWith(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
      interviewReport: freezed == interviewReport
          ? _value.interviewReport
          : interviewReport // ignore: cast_nullable_to_non_nullable
              as InterviewReportsResponse?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InterviewReportStateImplCopyWith<$Res>
    implements $InterviewReportStateCopyWith<$Res> {
  factory _$$InterviewReportStateImplCopyWith(_$InterviewReportStateImpl value,
          $Res Function(_$InterviewReportStateImpl) then) =
      __$$InterviewReportStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Result? result, InterviewReportsResponse? interviewReport});
}

/// @nodoc
class __$$InterviewReportStateImplCopyWithImpl<$Res>
    extends _$InterviewReportStateCopyWithImpl<$Res, _$InterviewReportStateImpl>
    implements _$$InterviewReportStateImplCopyWith<$Res> {
  __$$InterviewReportStateImplCopyWithImpl(_$InterviewReportStateImpl _value,
      $Res Function(_$InterviewReportStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of InterviewReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? interviewReport = freezed,
  }) {
    return _then(_$InterviewReportStateImpl(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
      interviewReport: freezed == interviewReport
          ? _value.interviewReport
          : interviewReport // ignore: cast_nullable_to_non_nullable
              as InterviewReportsResponse?,
    ));
  }
}

/// @nodoc

class _$InterviewReportStateImpl implements _InterviewReportState {
  const _$InterviewReportStateImpl({this.result, this.interviewReport});

  /// API処理結果
  @override
  final Result? result;

  /// 面談結果一覧
  @override
  final InterviewReportsResponse? interviewReport;

  @override
  String toString() {
    return 'InterviewReportState(result: $result, interviewReport: $interviewReport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterviewReportStateImpl &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.interviewReport, interviewReport) ||
                other.interviewReport == interviewReport));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result, interviewReport);

  /// Create a copy of InterviewReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InterviewReportStateImplCopyWith<_$InterviewReportStateImpl>
      get copyWith =>
          __$$InterviewReportStateImplCopyWithImpl<_$InterviewReportStateImpl>(
              this, _$identity);
}

abstract class _InterviewReportState implements InterviewReportState {
  const factory _InterviewReportState(
          {final Result? result,
          final InterviewReportsResponse? interviewReport}) =
      _$InterviewReportStateImpl;

  /// API処理結果
  @override
  Result? get result;

  /// 面談結果一覧
  @override
  InterviewReportsResponse? get interviewReport;

  /// Create a copy of InterviewReportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InterviewReportStateImplCopyWith<_$InterviewReportStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
