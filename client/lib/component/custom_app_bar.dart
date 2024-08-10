import 'package:client/constant/color.dart';
import 'package:flutter/material.dart';

class CostomAppBar {
  /// スタート画面[ProfileInputView]と[AvatarSelectView]のAppBar
  final startAppBar = AppBar(
    backgroundColor: ColorDefinitions.secondaryColor,
    title: const Text("学生面談(工学部)"),
    titleTextStyle: const TextStyle(
      color: ColorDefinitions.textColor,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
  );
}
