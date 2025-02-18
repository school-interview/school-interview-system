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

  /// アバターリスト取得APIレスポンス
  List<Teacher> get avatarList => throw _privateConstructorUsedError;
  int get avatarCount => throw _privateConstructorUsedError;

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
      List<Teacher> avatarList,
      int avatarCount});
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
    Object? avatarList = null,
    Object? avatarCount = null,
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
      avatarList: null == avatarList
          ? _value.avatarList
          : avatarList // ignore: cast_nullable_to_non_nullable
              as List<Teacher>,
      avatarCount: null == avatarCount
          ? _value.avatarCount
          : avatarCount // ignore: cast_nullable_to_non_nullable
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
      List<Teacher> avatarList,
      int avatarCount});
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
    Object? avatarList = null,
    Object? avatarCount = null,
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
      avatarList: null == avatarList
          ? _value._avatarList
          : avatarList // ignore: cast_nullable_to_non_nullable
              as List<Teacher>,
      avatarCount: null == avatarCount
          ? _value.avatarCount
          : avatarCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AvatarSelectViewStateImpl implements _AvatarSelectViewState {
  const _$AvatarSelectViewStateImpl(
      {this.result,
      this.isLoading = false,
      final List<Teacher> avatarList = const [],
      this.avatarCount = 0})
      : _avatarList = avatarList;

  /// API処理結果
  @override
  final Result? result;

  /// 読み込み中フラグ
  @override
  @JsonKey()
  final bool isLoading;

  /// アバターリスト取得APIレスポンス
  final List<Teacher> _avatarList;

  /// アバターリスト取得APIレスポンス
  @override
  @JsonKey()
  List<Teacher> get avatarList {
    if (_avatarList is EqualUnmodifiableListView) return _avatarList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_avatarList);
  }

  @override
  @JsonKey()
  final int avatarCount;

  @override
  String toString() {
    return 'AvatarSelectViewState(result: $result, isLoading: $isLoading, avatarList: $avatarList, avatarCount: $avatarCount)';
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
                .equals(other._avatarList, _avatarList) &&
            (identical(other.avatarCount, avatarCount) ||
                other.avatarCount == avatarCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result, isLoading,
      const DeepCollectionEquality().hash(_avatarList), avatarCount);

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
      final List<Teacher> avatarList,
      final int avatarCount}) = _$AvatarSelectViewStateImpl;

  @override

  /// API処理結果
  Result? get result;
  @override

  /// 読み込み中フラグ
  bool get isLoading;
  @override

  /// アバターリスト取得APIレスポンス
  List<Teacher> get avatarList;
  @override
  int get avatarCount;
  @override
  @JsonKey(ignore: true)
  _$$AvatarSelectViewStateImplCopyWith<_$AvatarSelectViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
