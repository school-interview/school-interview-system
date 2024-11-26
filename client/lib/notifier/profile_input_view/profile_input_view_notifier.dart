import 'package:client/app.dart';
import 'package:client/constant/result.dart';
import 'package:client/constant/select_items.dart';
import 'package:client/infrastructure/shared_preference_manager.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/student/student_repository.dart';
import 'package:client/repository/student/student_repository_impl.dart';
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

  /// 以下、setter
  void setResult(Result result) => state = state.copyWith(result: result);

  /// 学生リポジトリ
  final StudentRepository _studentRepository = StudentRepositoryImpl();

  /// 永続化マネージャー
  final SharedPreferenceManager _sharedPreferenceManager =
      SharedPreferenceManager();

  /// ユーザー情報登録APIを実行
  Future<void> putStudentInfo(StudentUpdate studentUpdate) async {
    try {
      final userId =
          await _sharedPreferenceManager.getString(PrefKeys.userId) ?? "";
      final idToken =
          await _sharedPreferenceManager.getString(PrefKeys.idToken) ?? "";
      ApiResult<Student> response = await _studentRepository.putStudentInfo(
        userId,
        studentUpdate,
        idToken,
      );
      switch (response.statusCode) {
        case 200:
          await _sharedPreferenceManager.setString(
              PrefKeys.userId, response.data!.userId);
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

  /// ローカルに保存する
  Future<void> saveStudentData(String key, String value) async {
    await _sharedPreferenceManager.setString(key, value);
  }

  /// 学生更新情報を取得
  Future<StudentUpdate> setStudentUpdate() async {
    final studentId =
        await _sharedPreferenceManager.getString(PrefKeys.studentId) ?? "";
    final department =
        await _sharedPreferenceManager.getString(PrefKeys.department) ?? "";
    final semesterString =
        await _sharedPreferenceManager.getString(PrefKeys.semester) ?? "";
    var semester = 1;
    const semesterSelect = SelectItems.semesters;
    for (var item in semesterSelect.entries) {
      if (item.value == semesterString) {
        semester = item.key;
      }
    }
    final studentUpdate = StudentUpdate(
        studentId: studentId, department: department, semester: semester);
    return studentUpdate;
  }
}
