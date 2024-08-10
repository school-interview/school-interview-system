import 'package:client/repository/user/user_repository.dart';
import 'package:client/repository/user/user_repository_impl.dart';
import 'package:client/view_model/profile_input/profile_input_view_model_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileInputViewModelProvider =
    StateNotifierProvider<ProfileInputViewModel, ProfileInputViewModelState>(
  (ref) => ProfileInputViewModel(
    userRepository: UserRepositoryImpl(),
  ),
);

class ProfileInputViewModel extends StateNotifier<ProfileInputViewModelState> {
  final UserRepository _userRepository;

  ProfileInputViewModel({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const ProfileInputViewModelState());

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
