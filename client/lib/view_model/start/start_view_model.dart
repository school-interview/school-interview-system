import 'package:client/repository/user/user_repository.dart';
import 'package:client/repository/user/user_repository_impl.dart';
import 'package:client/view_model/start/start_view_model_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final startViewModelProvider =
    StateNotifierProvider<StartViewModel, StartViewModelState>(
  (ref) => StartViewModel(
    userRepository: UserRepositoryImpl(),
  ),
);

class StartViewModel extends StateNotifier<StartViewModelState> {
  final UserRepository _userRepository;

  StartViewModel({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const StartViewModelState());

  setName(String name) {
    state = state.copyWith(name: name);
  }

  setSchoolNumber(String schoolNumber) {
    state = state.copyWith(schoolNumber: schoolNumber);
  }

  setClassColumnNumber(String classColumnNumber) {
    state = state.copyWith(classColmunNumber: classColumnNumber);
  }
}
