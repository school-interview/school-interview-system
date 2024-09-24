/// API 呼び出しの結果を表すクラス。
///
/// [statusCode] HTTPステータスコード
/// [data] 成功時にデコードされたデータ
class ApiResult<T> {
  /// HTTP ステータスコード。
  final int statusCode;

  /// 成功時にデコードされたデータ。
  final T? data;

  /// [statusCode]、[data]を指定して `ApiResult` オブジェクトを生成します。
  ApiResult({required this.statusCode, this.data});

  /// ステータスコードが 200 番台の場合に `true` を返します。
  bool get isSuccess {
    return statusCode >= 200 && statusCode < 300;
  }
}