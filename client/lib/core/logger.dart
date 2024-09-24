import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

/// シンプルな出力
class ExtensionLogPrinter extends SimplePrinter {
  Map<Level, String> getLevelPrefixes() => SimplePrinter.levelPrefixes;

  Map<Level, AnsiColor> getLevelColors() => SimplePrinter.levelColors;

  /// ラベルに色をつける
  String _labelFor(Level level, dynamic messages) {
    final levelPrefixes = getLevelPrefixes();
    var prefix = levelPrefixes[level]!;
    final levelColors = getLevelColors();
    var color = levelColors[level]!;

    return colors ? color('$prefix $messages') : '$prefix $messages';
  }

  @override
  List<String> log(LogEvent event) {
    final message = event.message;

    String msg;
    if (message is Function()) {
      msg = message().toString();
    } else if (message is String) {
      msg = message;
    } else {
      msg = message.toString();
    }
    return [
      '${_labelFor(event.level, '${DateFormat('HH:mm:ss.SSS').format(DateTime.now())}: $msg')} '
    ];
  }
}

class ExtensionLogOutput extends ConsoleOutput {
  @override
  void output(OutputEvent event) {
    super.output(event);
    if (event.level.index >= Level.error.index) {
      // 致命的なエラーが発生したのでAssertionErrorをthrowしてStackTraceを表示する
      throw AssertionError('View stack trace by logger');
    }
  }
}

/// ロガー拡張
extension LoggerExtension on Logger {
  // ★★★ デバック用(リリース時は確実にfalseにすること) ★★★
  bool isDebugOutput() => true;

  /// Log a method enter.
  void enter({dynamic message}) {
    final stackTrace = StackTrace.current.toString();

    var topStack = stackTrace;
    if (stackTrace.contains("#1")) {
      topStack = stackTrace.split("#1")[1];
    }
    if (stackTrace.contains("#2")) {
      topStack = topStack.split("#2")[0];
    }
    if (isDebugOutput()) {
      // デバッグ用
      if (message == null) {
        print(
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) <<< enter <<<");
      } else {
        print(
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) <<< enter : $message");
      }
    } else {
      if (message == null) {
        log(Level.debug,
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) <<< enter <<<");
      } else {
        log(Level.debug,
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) <<< enter : $message");
      }
    }
  }

  /// Log a method exit.
  void exit({dynamic message}) {
    final stackTrace = StackTrace.current.toString();
    final topStack = stackTrace.split("#1")[1].split("#2")[0];
    if (isDebugOutput()) {
      // デバッグ用
      if (message == null) {
        print(
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) >>> exit >>>");
      } else {
        print(
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) >>> exit : $message");
      }
    } else {
      if (message == null) {
        log(Level.debug,
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) >>> exit >>>");
      } else {
        log(Level.debug,
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) >>> exit : $message");
      }
    }
  }

  void debug({dynamic message}) {
    final stackTrace = StackTrace.current.toString();
    final topStack = stackTrace.split("#1")[1].split("#2")[0];
    if (isDebugOutput()) {
      // デバッグ用
      if (message == null) {
        print("${topStack.substring(0, topStack.indexOf(")")).trim()})");
      } else {
        print(
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) : $message");
      }
    } else {
      if (message == null) {
        log(Level.debug,
            "${topStack.substring(0, topStack.indexOf(")")).trim()})");
      } else {
        log(Level.debug,
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) : $message");
      }
    }
  }

  void info({dynamic message}) {
    final stackTrace = StackTrace.current.toString();
    final topStack = stackTrace.split("#1")[1].split("#2")[0];
    if (isDebugOutput()) {
      // デバッグ用
      if (message == null) {
        print("${topStack.substring(0, topStack.indexOf(")")).trim()})");
      } else {
        print(
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) : $message");
      }
    } else {
      if (message == null) {
        log(Level.info,
            "${topStack.substring(0, topStack.indexOf(")")).trim()})");
      } else {
        log(Level.info,
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) : $message");
      }
    }
  }

  void warning({dynamic message}) {
    final stackTrace = StackTrace.current.toString();
    final topStack = stackTrace.split("#1")[1].split("#2")[0];
    if (isDebugOutput()) {
      // デバッグ用
      if (message == null) {
        print("${topStack.substring(0, topStack.indexOf(")")).trim()})");
      } else {
        print(
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) : $message");
      }
    } else {
      if (message == null) {
        log(Level.warning,
            "${topStack.substring(0, topStack.indexOf(")")).trim()})");
      } else {
        log(Level.warning,
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) : $message");
      }
    }
  }

  void error({dynamic message}) {
    final stackTrace = StackTrace.current.toString();
    final topStack = stackTrace.split("#1")[1].split("#2")[0];
    if (isDebugOutput()) {
      // デバッグ用
      if (message == null) {
        print("${topStack.substring(0, topStack.indexOf(")")).trim()})");
      } else {
        print(
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) : $message");
      }
    } else {
      if (message == null) {
        log(Level.error,
            "${topStack.substring(0, topStack.indexOf(")")).trim()})");
      } else {
        log(Level.error,
            "${topStack.substring(0, topStack.indexOf(")")).trim()}) : $message");
      }
    }
  }
}
