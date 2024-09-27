import 'package:client/app.dart';
import 'package:client/constant/result.dart';
import 'package:client/infrastructure/shared_preference_manager.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/login/login_repository.dart';
import 'package:client/repository/login/login_repository_impl.dart';
import 'package:client/view/profile_input/profile_input_view_state.dart';
import 'package:openapi/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_input_view_notifier.g.dart';

@riverpod
class ProfileInputViewNotifier extends _$ProfileInputViewNotifier {
  @override
  ProfileInputViewState build() {
    return const ProfileInputViewState();
  }

  void setResult(Result result) {
    state = state.copyWith(result: result);
  }

  void setStudentId(String studentId) {
    state = state.copyWith(studentId: studentId);
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setDepartment(String department) {
    state = state.copyWith(department: department);
  }

  void setSemester(int semester) {
    state = state.copyWith(semester: semester);
  }

  /// ログインリポジトリ
  final LoginRepository _loginRepository = LoginRepositoryImpl();

  /// 永続化マネージャー
  final SharedPreferenceManager _sharedPreferenceManager =
      SharedPreferenceManager();

  /// ユーザー情報登録APIを実行
  Future<void> putUserInfo() async {
    // 学生情報
    final userInfo = LoginRequest(
      studentId: state.studentId,
      name: state.name,
      department: state.department,
      semester: state.semester,
    );
    try {
      ApiResult<User> response = await _loginRepository.putUserInfo(userInfo);
      switch (response.statusCode) {
        case 200:
          await _sharedPreferenceManager.setString(
            PrefKeys.userId,
            response.data!.id,
          );
          setResult(Result.success);
          break;
        default:
          setResult(Result.fail);
          break;
      }
      logger.t("responseData:${response.data}");
    } on Exception catch (e) {
      logger.e(e.toString());
      setResult(Result.fail);
      return;
    }
  }
}
