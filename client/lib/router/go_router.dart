import 'package:client/view/avatar_select/avatar_select_view.dart';
import 'package:client/view/interview/interview_view.dart';
import 'package:client/view/profile_input/profile_input_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  // アプリが起動した時
  initialLocation: '/profile-input',
  // パスと画面の組み合わせ
  routes: [
    // 情報入力画面
    GoRoute(
      path: '/profile-input',
      name: 'profileInput',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const ProfileInputView(),
        );
      },
    ),
    // アバター選択画面
    GoRoute(
      path: '/avatar-select',
      name: 'avatarSelect',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const AvatarSelectView(),
        );
      },
    ),
    // 面談画面
    GoRoute(
      path: '/interview',
      name: 'interview',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const InterviewView(),
        );
      },
    ),
  ],

  // 遷移ページがないなどのエラーが発生した時に、このページに行く
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);