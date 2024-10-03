import 'package:client/view/avatar_select/avatar_select_view.dart';
import 'package:client/view/interview/interview_view.dart';
import 'package:client/view/interview_analytics/interview_analytics_view.dart';
import 'package:client/view/profile_input/profile_input_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  // アプリが起動した時
  initialLocation: RouterPath.profileInputView,
  // パスと画面の組み合わせ
  routes: [
    // 情報入力画面
    GoRoute(
      path: RouterPath.profileInputView,
      name: RouterPath.profileInputView,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const ProfileInputView(),
        );
      },
    ),
    // アバター選択画面
    GoRoute(
      path: RouterPath.avatarSelectView,
      name: RouterPath.avatarSelectView,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const AvatarSelectView(),
        );
      },
    ),
    // 面談画面
    GoRoute(
      path: RouterPath.interviewView,
      name: RouterPath.interviewView,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const InterviewView(),
        );
      },
    ),
    // 要支援レベル画面
    GoRoute(
      path: RouterPath.interviewAnalyticsView,
      name: RouterPath.interviewAnalyticsView,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const InterviewAnalyticsView(),
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

/// 画面パス
class RouterPath {
  // 情報入力画面
  static const String profileInputView = "/profile-input";

  // アバター選択画面
  static const String avatarSelectView = "/avatar-select";

  // 面談画面
  static const String interviewView = "/interview";

  // 要支援レベル画面
  static const String interviewAnalyticsView = "/interview-analytics";
}
