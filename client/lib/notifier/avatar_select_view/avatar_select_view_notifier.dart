import 'package:client/app.dart';
import 'package:client/constant/result.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/avatar/avatar_repository_impl.dart';
import 'package:client/view/avatar_select/avatar_select_view_state.dart';
import 'package:openapi/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'avatar_select_view_notifier.g.dart';

@riverpod
class AvatarSelectViewNotifier extends _$AvatarSelectViewNotifier {
  @override
  AvatarSelectViewState build() {
    return const AvatarSelectViewState();
  }

  final _teacherRepository = AvatarRepositoryImpl();

  void _setResult(Result result) => state = state.copyWith(result: result);

  void setIsLoading(bool isLoading) =>
      state = state.copyWith(isLoading: isLoading);

  void _setAvatarList(List<Teacher> avatarList) =>
      state = state.copyWith(avatarList: avatarList);

  void _setAvatarCount(int avatarCount) =>
      state = state.copyWith(avatarCount: avatarCount);

  /// アバターリスト取得API
  Future<void> getAvatarList() async {
    try {
      ApiResult<TeachersListResponse> response =
          await _teacherRepository.getAvatarList();
      switch (response.statusCode) {
        case 200:
          _setAvatarList(response.data!.teachers);
          _setAvatarCount(response.data!.count);
          _setResult(Result.success);
          logger.t("responseData:${response.data}");
          break;
        default:
          _setResult(Result.fail);
          break;
      }
    } on Exception catch (e) {
      _setResult(Result.fail);
      logger.e(e.toString());
      return;
    }
  }
}
