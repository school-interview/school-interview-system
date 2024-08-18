// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_view_model_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MainViewModelState {
  Locale get language => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MainViewModelStateCopyWith<MainViewModelState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainViewModelStateCopyWith<$Res> {
  factory $MainViewModelStateCopyWith(
          MainViewModelState value, $Res Function(MainViewModelState) then) =
      _$MainViewModelStateCopyWithImpl<$Res, MainViewModelState>;
  @useResult
  $Res call({Locale language});
}

/// @nodoc
class _$MainViewModelStateCopyWithImpl<$Res, $Val extends MainViewModelState>
    implements $MainViewModelStateCopyWith<$Res> {
  _$MainViewModelStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
  }) {
    return _then(_value.copyWith(
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Locale,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MainViewModelStateImplCopyWith<$Res>
    implements $MainViewModelStateCopyWith<$Res> {
  factory _$$MainViewModelStateImplCopyWith(_$MainViewModelStateImpl value,
          $Res Function(_$MainViewModelStateImpl) then) =
      __$$MainViewModelStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Locale language});
}

/// @nodoc
class __$$MainViewModelStateImplCopyWithImpl<$Res>
    extends _$MainViewModelStateCopyWithImpl<$Res, _$MainViewModelStateImpl>
    implements _$$MainViewModelStateImplCopyWith<$Res> {
  __$$MainViewModelStateImplCopyWithImpl(_$MainViewModelStateImpl _value,
      $Res Function(_$MainViewModelStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
  }) {
    return _then(_$MainViewModelStateImpl(
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Locale,
    ));
  }
}

/// @nodoc

class _$MainViewModelStateImpl implements _MainViewModelState {
  const _$MainViewModelStateImpl({this.language = const Locale('ja')});

  @override
  @JsonKey()
  final Locale language;

  @override
  String toString() {
    return 'MainViewModelState(language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainViewModelStateImpl &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @override
  int get hashCode => Object.hash(runtimeType, language);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainViewModelStateImplCopyWith<_$MainViewModelStateImpl> get copyWith =>
      __$$MainViewModelStateImplCopyWithImpl<_$MainViewModelStateImpl>(
          this, _$identity);
}

abstract class _MainViewModelState implements MainViewModelState {
  const factory _MainViewModelState({final Locale language}) =
      _$MainViewModelStateImpl;

  @override
  Locale get language;
  @override
  @JsonKey(ignore: true)
  _$$MainViewModelStateImplCopyWith<_$MainViewModelStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
