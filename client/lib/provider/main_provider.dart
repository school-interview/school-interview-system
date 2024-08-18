import 'package:client/repository/user/user_repository_impl.dart';
import 'package:client/view_model/main/main_view_model.dart';
import 'package:client/view_model/main/main_view_model_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainViewModelProvider =
    StateNotifierProvider<MainViewModel, MainViewModelState>(
  (ref) => MainViewModel(
    userRepository: UserRepositoryImpl(),
  ),
);