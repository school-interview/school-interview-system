import 'package:client/repository/api_result.dart';
import 'package:openapi/api.dart';

/// アバターリストを取得するためのリポジトリ
abstract class AvatarRepository {
  /// アバターリスト取得API
  Future<ApiResult<TeachersListResponse>> getAvatarList();
}
