import 'package:client/view/profile_input/profile_input_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        scrollBehavior: CustomScrollBehavior(),
        home: const ProfileInputView(),
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
