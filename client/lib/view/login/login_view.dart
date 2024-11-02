import 'dart:html' as html;

import 'package:client/component/custom_app_bar.dart';
import 'package:client/constant/color.dart';
import 'package:client/constant/result.dart';
import 'package:client/constant/uri_string.dart';
import 'package:client/notifier/login/login_notifier.dart';
import 'package:client/router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_button/sign_in_button.dart';

/// ログイン画面
class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginView();
}

class _LoginView extends ConsumerState<LoginView> {
  @override
  Widget build(BuildContext context) {
    ref.listen<Result?>(loginNotifierProvider.select((value) => value.result),
        (_, next) {
      // 処理結果ハンドリング
      _handleResult(context, next);
    });
    return Scaffold(
      backgroundColor: ColorDefinitions.primaryColor,
      appBar: CustomAppBar().startAppBar(context),
      body: Center(
        child: SizedBox(
          height: 60,
          child: SignInButton(
            padding: const EdgeInsets.all(16),
            Buttons.google,
            text: "Googleでログイン",
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onPressed: () {
              /// TODO iOSとAndroidでの実装
              /// モバイルアプリではポップアップが表示されません
              final loginNotifier = ref.read(loginNotifierProvider.notifier);
              html.window.open(UriString.googleLoginPageUri, "ログイン",
                  'left=100,top=100,width=700,height=500');
              html.window.onMessage.listen(
                (html.MessageEvent event) async {
                  loginNotifier.login(event.data);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  /// 処理結果ハンドリング
  ///
  /// [result] 処理結果
  void _handleResult(BuildContext context, Result? result) {
    // final loginNotifier = ref.read(loginNotifierProvider.notifier);
    final loginState = ref.watch(loginNotifierProvider);
    switch (result) {
      case Result.success:
        // loginNotifier.setResult(null);
        if (loginState.user?.isAdmin == true) {
          // 教員向け画面へ遷移する
          // TODO 教員向け画面を実装する
        } else if (loginState.user?.isAdmin == false) {
          // 学生向け画面へ遷移する
          context.push(RouterPath.profileInputView);
        }
        break;
      case Result.fail:
        // TODO API処理に失敗した際の処理を追加する（アラートを表示→再度API実行など）
        break;
      default:
        break;
    }
  }
}
