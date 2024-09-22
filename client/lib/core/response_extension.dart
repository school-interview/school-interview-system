import 'package:http/http.dart';

extension ResponseExt on Response {
  bool isSuccess() {
    final code = statusCode;
    return code >= 200 && code < 300;
  }
}