import 'package:client/view/start/start_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        scrollBehavior: CustomScrollBehavior(),
        home: const StartView(),
      ),
    ),
  );
}

// スクロールの挙動をカスタマイズするためのクラス
class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        // Webでのスクロールをマウスで行うために追加
        PointerDeviceKind.mouse,
      };
}
