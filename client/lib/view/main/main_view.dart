import 'dart:ui';

import 'package:client/generated/l10n.dart';
import 'package:client/view/unity_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 画面全体のウィジェット
class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<MainView> createState() => _MainView();
}

class _MainView extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 初期画面
      home: const UnityDemoScreen(),
      scrollBehavior: CustomScrollBehavior(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
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
