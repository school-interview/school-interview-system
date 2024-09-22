import 'package:client/core/logger.dart';
import 'package:logger/logger.dart';

// ロガー
final logger = Logger(
  // ログ出力内容をシンプルにカスタマイズ
  printer: ExtensionLogPrinter(),
  // ログ出力したあとに処理を挿入する
  output: ExtensionLogOutput(),
);