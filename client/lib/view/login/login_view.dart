import 'dart:html' as html;

import 'package:client/component/custom_app_bar.dart';
import 'package:client/constant/color.dart';
import 'package:client/constant/uri_string.dart';
import 'package:client/notifier/login/login_notifier.dart';
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
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              /// 現在の実装ではモバイルアプリでは動きません
              final loginNotifier = ref.read(loginNotifierProvider.notifier);
              html.window.open(UriString.googleLoginPageUri, "ログイン",
                  'left=100,top=100,width=700,height=400');
              html.window.onMessage.listen(
                (html.MessageEvent event) async {
                  await loginNotifier.getLoginToken();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
