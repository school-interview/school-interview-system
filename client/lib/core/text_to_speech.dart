import 'package:client/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// テキストを音声に変換するクラス
class TextToSpeech {
  // FlutterTtsのインスタンスを作成
  static FlutterTts tts = FlutterTts();

  // テキストを音声に変換するための初期化処理
  static initTTS(BuildContext context) {
    // 言語を設定
    Locale locale = Localizations.localeOf(context);
    String stringLocale = "$locale";
    tts.setLanguage(stringLocale);
  }

  /// テキストを音声に変換して再生する
  static speak(
    String text, {
    Function? startFunc,
    required Function endFunc,
  }) async {
    // アバターが話し始めたときの処理
    tts.setStartHandler(() {
      if (startFunc != null) {
        startFunc();
      }
      logger.i("TTS STARTED");
    });

    // アバターが話し終えたときの処理
    tts.setCompletionHandler(() {
      endFunc();
      logger.i("TTS COMPLETED");
    });

    tts.setErrorHandler((message) {
      logger.e(message);
    });

    await tts.setSpeechRate(1.5); // 速度を設定
    await tts.setVolume(1.0); // 音量を設定
    await tts.setPitch(1.0); // ピッチを設定
    await tts.awaitSpeakCompletion(true);
    await tts.speak(text); // テキストを音声に変換して再生する
  }
}
