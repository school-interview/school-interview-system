import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_input_view_model_state.freezed.dart';

@freezed
abstract class ProfileInputViewModelState with _$ProfileInputViewModelState {
  const factory ProfileInputViewModelState({
    @Default("") String name,
    @Default(1) int semester,
    @Default("") department,
    @Default("") String schoolNumber,
    @Default("") String classColmunNumber,
  }) = _ProfileInputViewModelState;
}
