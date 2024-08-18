import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_view_model_state.freezed.dart';

@freezed
abstract class MainViewModelState with _$MainViewModelState {
  const factory MainViewModelState({
    @Default(Locale('ja')) Locale language,
  }) = _MainViewModelState;
}
