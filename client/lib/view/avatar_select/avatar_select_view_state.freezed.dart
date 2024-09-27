// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'avatar_select_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AvatarSelectViewState {
  /// API処理結果
  Result? get result => throw _privateConstructorUsedError;

  /// 教員リストレスポンス
  TeachersListResponse? get teacherListResponse =>
      throw _privateConstructorUsedError;

  /// 教員ID
  String get selectedTeacherId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AvatarSelectViewStateCopyWith<AvatarSelectViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvatarSelectViewStateCopyWith<$Res> {
  factory $AvatarSelectViewStateCopyWith(AvatarSelectViewState value,
          $Res Function(AvatarSelectViewState) then) =
      _$AvatarSelectViewStateCopyWithImpl<$Res, AvatarSelectViewState>;
  @useResult
  $Res call(
      {Result? result,
      TeachersListResponse? teacherListResponse,
      String selectedTeacherId});
}

/// @nodoc
class _$AvatarSelectViewStateCopyWithImpl<$Res,
        $Val extends AvatarSelectViewState>
    implements $AvatarSelectViewStateCopyWith<$Res> {
  _$AvatarSelectViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? teacherListResponse = freezed,
    Object? selectedTeacherId = null,
  }) {
    return _then(_value.copyWith(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
      teacherListResponse: freezed == teacherListResponse
          ? _value.teacherListResponse
          : teacherListResponse // ignore: cast_nullable_to_non_nullable
              as TeachersListResponse?,
      selectedTeacherId: null == selectedTeacherId
          ? _value.selectedTeacherId
          : selectedTeacherId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AvatarSelectViewStateImplCopyWith<$Res>
    implements $AvatarSelectViewStateCopyWith<$Res> {
  factory _$$AvatarSelectViewStateImplCopyWith(
          _$AvatarSelectViewStateImpl value,
          $Res Function(_$AvatarSelectViewStateImpl) then) =
      __$$AvatarSelectViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Result? result,
      TeachersListResponse? teacherListResponse,
      String selectedTeacherId});
}

/// @nodoc
class __$$AvatarSelectViewStateImplCopyWithImpl<$Res>
    extends _$AvatarSelectViewStateCopyWithImpl<$Res,
        _$AvatarSelectViewStateImpl>
    implements _$$AvatarSelectViewStateImplCopyWith<$Res> {
  __$$AvatarSelectViewStateImplCopyWithImpl(_$AvatarSelectViewStateImpl _value,
      $Res Function(_$AvatarSelectViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? teacherListResponse = freezed,
    Object? selectedTeacherId = null,
  }) {
    return _then(_$AvatarSelectViewStateImpl(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
      teacherListResponse: freezed == teacherListResponse
          ? _value.teacherListResponse
          : teacherListResponse // ignore: cast_nullable_to_non_nullable
              as TeachersListResponse?,
      selectedTeacherId: null == selectedTeacherId
          ? _value.selectedTeacherId
          : selectedTeacherId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AvatarSelectViewStateImpl implements _AvatarSelectViewState {
  const _$AvatarSelectViewStateImpl(
      {this.result, this.teacherListResponse, this.selectedTeacherId = ""});

  /// API処理結果
  @override
  final Result? result;

  /// 教員リストレスポンス
  @override
  final TeachersListResponse? teacherListResponse;

  /// 教員ID
  @override
  @JsonKey()
  final String selectedTeacherId;

  @override
  String toString() {
    return 'AvatarSelectViewState(result: $result, teacherListResponse: $teacherListResponse, selectedTeacherId: $selectedTeacherId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvatarSelectViewStateImpl &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.teacherListResponse, teacherListResponse) ||
                other.teacherListResponse == teacherListResponse) &&
            (identical(other.selectedTeacherId, selectedTeacherId) ||
                other.selectedTeacherId == selectedTeacherId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, result, teacherListResponse, selectedTeacherId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AvatarSelectViewStateImplCopyWith<_$AvatarSelectViewStateImpl>
      get copyWith => __$$AvatarSelectViewStateImplCopyWithImpl<
          _$AvatarSelectViewStateImpl>(this, _$identity);
}

abstract class _AvatarSelectViewState implements AvatarSelectViewState {
  const factory _AvatarSelectViewState(
      {final Result? result,
      final TeachersListResponse? teacherListResponse,
      final String selectedTeacherId}) = _$AvatarSelectViewStateImpl;

  @override

  /// API処理結果
  Result? get result;
  @override

  /// 教員リストレスポンス
  TeachersListResponse? get teacherListResponse;
  @override

  /// 教員ID
  String get selectedTeacherId;
  @override
  @JsonKey(ignore: true)
  _$$AvatarSelectViewStateImplCopyWith<_$AvatarSelectViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
