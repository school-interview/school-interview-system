import 'package:client/app.dart';
import 'package:client/constant/result.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/teacher/teacher_repository_impl.dart';
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

  final _teacherRepository = TeacherRepositoryImpl();

  void _setResult(Result result) {
    state = state.copyWith(result: result);
  }

  void _setTeacherList(List<Teacher> teacherList) {
    state = state.copyWith(teacherList: teacherList);
  }

  void _setTeacherCount(int teacherCount) {
    state = state.copyWith(teacherCount: teacherCount);
  }

  /// 教員リスト取得API
  Future<void> getTeacherList() async {
    try {
      ApiResult<TeachersListResponse> response =
          await _teacherRepository.getTeacherList();
      switch (response.statusCode) {
        case 200:
          _setTeacherList(response.data!.teachers);
          _setTeacherCount(response.data!.count);
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
