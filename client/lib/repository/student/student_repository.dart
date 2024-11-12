import 'package:client/repository/api_result.dart';
import 'package:openapi/api.dart';

/// 学生情報関連のリポジトリ
abstract class StudentRepository {
  /// 学生情報更新API
  Future<ApiResult<Student>> putStudentInfo(
    String userId,
    StudentUpdate studentUpdate,
    String idToken,
  );
}
