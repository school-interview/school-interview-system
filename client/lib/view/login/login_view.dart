import 'dart:html' as html;

import 'package:client/app.dart';
import 'package:client/component/custom_app_bar.dart';
import 'package:client/constant/color.dart';
import 'package:client/constant/result.dart';
import 'package:client/constant/uri_string.dart';
import 'package:client/notifier/login/login_notifier.dart';
import 'package:client/view/profile_input/profile_input_view.dart';
import 'package:client/view/result_management/result_management_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
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
                  final loginNotifier =
                      ref.read(loginNotifierProvider.notifier);
                  html.window.open(UriString.googleLoginPageUri, "ログイン",
                      'left=100,top=100,width=700,height=500');
                  html.window.onMessage.listen(
                    (html.MessageEvent event) async {
                      await loginNotifier.login(event.data);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 48),

            // アカウントについての注意書き
            Container(
              width: 300,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: const Text(
                "ログインには大学から付与されたアカウントを使用してください。大学のアカウント以外でログインした場合エラーが発生します。",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 処理結果ハンドリング
  ///
  /// [result] 処理結果
  void _handleResult(BuildContext context, Result? result) {
    logger.i("_handleResult($result)");
    final loginNotifier = ref.read(loginNotifierProvider.notifier);
    final loginState = ref.watch(loginNotifierProvider);
    switch (result) {
      case Result.success:
        loginNotifier.setResult(null);
        if (loginState.isAdmin == true) {
          // 教員向け画面へ遷移する
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return const ResultManagementView();
            }),
          );
          break;
        } else if (loginState.isAdmin == false) {
          final state = ref.watch(loginNotifierProvider);
          // 学生向け画面へ遷移する
          if (state.user != null) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return ProfileInputView(name: state.user!.name);
              }),
            );
          } else {
            // TODO ユーザ情報がnullのときはダイアログを表示してログイン画面へ
          }
          break;
        } else {
          // TODO 教員か学生かが不明である旨を知らせるアラート表示
          logger.w("教員か学生かが不明です");
        }
        break;
      case Result.fail:
        loginNotifier.setResult(null);
        // TODO API処理に失敗した際の処理を追加する（アラートを表示→再度API実行など）
        break;
      default:
        break;
    }
  }
}
