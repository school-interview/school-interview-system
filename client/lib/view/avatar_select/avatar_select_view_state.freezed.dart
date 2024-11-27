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

  /// 読み込み中フラグ
  bool get isLoading => throw _privateConstructorUsedError;

  /// 教員リスト取得APIレスポンス
  List<Teacher> get teacherList => throw _privateConstructorUsedError;
  int get teacherCount => throw _privateConstructorUsedError;

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
      bool isLoading,
      List<Teacher> teacherList,
      int teacherCount});
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
    Object? isLoading = null,
    Object? teacherList = null,
    Object? teacherCount = null,
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
      teacherList: null == teacherList
          ? _value.teacherList
          : teacherList // ignore: cast_nullable_to_non_nullable
              as List<Teacher>,
      teacherCount: null == teacherCount
          ? _value.teacherCount
          : teacherCount // ignore: cast_nullable_to_non_nullable
              as int,
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
      bool isLoading,
      List<Teacher> teacherList,
      int teacherCount});
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
    Object? isLoading = null,
    Object? teacherList = null,
    Object? teacherCount = null,
  }) {
    return _then(_$AvatarSelectViewStateImpl(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      teacherList: null == teacherList
          ? _value._teacherList
          : teacherList // ignore: cast_nullable_to_non_nullable
              as List<Teacher>,
      teacherCount: null == teacherCount
          ? _value.teacherCount
          : teacherCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AvatarSelectViewStateImpl implements _AvatarSelectViewState {
  const _$AvatarSelectViewStateImpl(
      {this.result,
      this.isLoading = false,
      final List<Teacher> teacherList = const [],
      this.teacherCount = 0})
      : _teacherList = teacherList;

  /// API処理結果
  @override
  final Result? result;

  /// 読み込み中フラグ
  @override
  @JsonKey()
  final bool isLoading;

  /// 教員リスト取得APIレスポンス
  final List<Teacher> _teacherList;

  /// 教員リスト取得APIレスポンス
  @override
  @JsonKey()
  List<Teacher> get teacherList {
    if (_teacherList is EqualUnmodifiableListView) return _teacherList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teacherList);
  }

  @override
  @JsonKey()
  final int teacherCount;

  @override
  String toString() {
    return 'AvatarSelectViewState(result: $result, isLoading: $isLoading, teacherList: $teacherList, teacherCount: $teacherCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvatarSelectViewStateImpl &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._teacherList, _teacherList) &&
            (identical(other.teacherCount, teacherCount) ||
                other.teacherCount == teacherCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result, isLoading,
      const DeepCollectionEquality().hash(_teacherList), teacherCount);

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
      final bool isLoading,
      final List<Teacher> teacherList,
      final int teacherCount}) = _$AvatarSelectViewStateImpl;

  @override

  /// API処理結果
  Result? get result;
  @override

  /// 読み込み中フラグ
  bool get isLoading;
  @override

  /// 教員リスト取得APIレスポンス
  List<Teacher> get teacherList;
  @override
  int get teacherCount;
  @override
  @JsonKey(ignore: true)
  _$$AvatarSelectViewStateImplCopyWith<_$AvatarSelectViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
