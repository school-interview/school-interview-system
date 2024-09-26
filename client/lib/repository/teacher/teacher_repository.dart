import 'package:client/repository/api_result.dart';
import 'package:openapi/api.dart';

/// 教員リストを取得するためのリポジトリ
abstract class TeacherRepository {
  /// 教員リスト取得API
  Future<ApiResult<List<Teacher>>> getTeachersList();
}
