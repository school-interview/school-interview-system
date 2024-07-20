import 'package:freezed_annotation/freezed_annotation.dart';

part 'start_view_model_state.freezed.dart';

@freezed
abstract class StartViewModelState with _$StartViewModelState {
  const factory StartViewModelState({
    @Default("") String name,
    @Default("") String schoolNumber,
    @Default("") String classColmunNumber,
  }) = _StartViewModelState;
}
