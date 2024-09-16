import 'package:client/constant/color.dart';
import 'package:client/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomAppBar {
  /// スタート画面[ProfileInputView]と[AvatarSelectView]のAppBar
  PreferredSizeWidget startAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorDefinitions.secondaryColor,
      title: Text(S.of(context).startAppBarTitle),
      titleTextStyle: const TextStyle(
        color: ColorDefinitions.textColor,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      automaticallyImplyLeading: false,
    );
  }
}
