import 'package:client/repository/user/user_repository.dart';
import 'package:client/view_model/main/main_view_model_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainViewModel extends StateNotifier<MainViewModelState> {
  MainViewModel({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const MainViewModelState());

  final UserRepository _userRepository;
}
