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

  void setResult(Result result) {
    state = state.copyWith(result: result);
  }

  void setTeacherList(TeachersListResponse teacherListResponse) {
    state = state.copyWith(teacherListResponse: teacherListResponse);
  }

  void setSelectedTeacherId(String selectedTeacherId) {
    state = state.copyWith(selectedTeacherId: selectedTeacherId);
  }

  /// 教員リスト取得API
  Future<void> getTeacherList() async {
    try {
      ApiResult<TeachersListResponse> response =
          await _teacherRepository.getTeacherList();
      switch (response.statusCode) {
        case 200:
          setTeacherList(response.data!);
          setResult(Result.success);
          logger.t("responseData:${response.data}");
          break;
        default:
          setResult(Result.fail);
          break;
      }
    } on Exception catch (e) {
      setResult(Result.fail);
      logger.e(e.toString());
      return;
    }
  }
}
