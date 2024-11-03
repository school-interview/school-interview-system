import 'package:client/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 面談結果管理画面（教員向けの画面）
class ResultManagementView extends ConsumerStatefulWidget {
  const ResultManagementView({super.key});

  @override
  ConsumerState<ResultManagementView> createState() => _ResultManagementView();
}

class _ResultManagementView extends ConsumerState<ResultManagementView> {
  @override
  void initState() {
    super.initState();
    Future(() async {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorDefinitions.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorDefinitions.secondaryColor,
        title: const Text("面談結果管理画面"),
        titleTextStyle: const TextStyle(
          color: ColorDefinitions.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
