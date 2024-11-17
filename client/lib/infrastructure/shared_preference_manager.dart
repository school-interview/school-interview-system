import 'package:shared_preferences/shared_preferences.dart';

/// 永続化マネージャー
class SharedPreferenceManager {
  /// 以下、登録
  Future<bool> setString(String key, String? value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (value != null) {
        return prefs.setString(key, value);
      } else {
        return prefs.remove(key); // nullにする
      }
    } catch (e) {
      throw Exception(' setString 保存キー：$key 保存Value：$value');
    }
  }

  /// 以下、取得
  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}

/// キーの一覧
class PrefKeys {
  static const String userId = "userID";
  static const String idToken = "idToken";
  static const String refreshToken = "refreshToken";
  static const String department = "department";
  static const String semester = "semester";
  static const String studentId = "studentId";
}
