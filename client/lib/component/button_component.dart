import 'package:client/constant/color.dart';
import 'package:flutter/material.dart';

/// ボタンのコンポーネントを持つクラス
class ButtonComponent {
  /// 角丸ボタン
  ///
  /// [labelText] ボタンのラベル文字列
  /// [onTapButton] ボタンをタップしたときの処理
  Widget normalButton({
    required String labelText,
    required Function() onTapButton,
  }) {
    return ElevatedButton(
      onPressed: () {
        onTapButton();
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: ColorDefinitions.accentColor,
      ),
      child: Text(labelText),
    );
  }
}