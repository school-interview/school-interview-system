import 'package:client/app.dart';
import 'package:client/constant/result.dart';
import 'package:client/core/logger.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/login/login_repository.dart';
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

  /// ログインリポジトリ
  late LoginRepository _loginRepository;

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

  void setResult(Result result) {
    state = state.copyWith(result: result);
  }

  /// ユーザー情報登録APIを実行
  Future<void> postUserInfo() async {
    logger.enter();
    // 学生情報
    final userInfo = LoginRequest(
      studentId: state.studentId,
      name: state.name,
      department: state.department,
      semester: state.semester,
    );

    try {
      ApiResult<User> response =
          await _loginRepository.putUserInformation(userInfo);
      switch (response.statusCode) {
        case 200:
          setResult(Result.success);
          break;
        default:
          setResult(Result.putUserInformationError);
          break;
      }
      logger.exit(message: "responseData:${response.data}");
    } on Exception catch (e) {
      logger.error(message: e.toString());
      setResult(Result.putUserInformationError);
      logger.exit();
      return;
    }
  }
}
