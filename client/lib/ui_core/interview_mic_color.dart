import 'package:client/constant/enum/who_talking.dart';
import 'package:flutter/material.dart';

/// 面談画面のマイクのUIを管理する
class InterviewMic {
  InterviewMic({
    required this.whoTalking,
  });

  /// 誰が話しているか
  WhoTalking whoTalking;

  /// マイクボタンのカラー
  Color? get micColor {
    switch (whoTalking) {
      case WhoTalking.user:
        return Colors.red;
      case WhoTalking.avatar:
        return Colors.grey;
      case WhoTalking.none:
        return Colors.blue[200];
      default:
        return null;
    }
  }

  /// マイクボタンのアイコン
  IconData? get micIcon {
    switch (whoTalking) {
      case WhoTalking.user:
        return Icons.stop;
      case WhoTalking.avatar:
        return Icons.mic_none;
      case WhoTalking.none:
        return Icons.mic;
      default:
        return null;
    }
  }
}
