import 'package:client/component/custom_app_bar.dart';
import 'package:client/component/style/box_shadow_style.dart';
import 'package:client/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvatarSelectView extends ConsumerStatefulWidget {
  const AvatarSelectView({super.key});

  @override
  ConsumerState<AvatarSelectView> createState() => _AvatarSelectView();
}

class _AvatarSelectView extends ConsumerState<AvatarSelectView> {
  @override
  void initState() {
    super.initState();
    Future(() {
      // Add your initialization code here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorDefinitions.primaryColor,
      appBar: CostomAppBar().startAppBar,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              const Text(
                "面談相手を選択してください",
                style: TextStyle(color: ColorDefinitions.textColor),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _avatarList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// アバターの一覧を生成するWidget
  Widget _avatarList() {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: GridView.builder(
            itemCount: 8,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 180,
            ),
            itemBuilder: (context, index) {
              return _avatarSelectBox(
                onTapSelectBox: () {
                  // セレクトボックスをタップした時の処理
                },
              );
            },
          ),
        ),
      ),
    );
  }

  /// アバターセレクトボックスを生成するWidget
  Widget _avatarSelectBox({required Function() onTapSelectBox}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: BoxShadowStyle.boxShadowStyle(),
      ),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        child: InkWell(
          onTap: onTapSelectBox,
          // リップルエフェクトの角を丸くするためにcustomBorderセット。
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ここに写真"),
              SizedBox(height: 8),
              Text("アバター名"),
            ],
          ),
        ),
      ),
    );
  }
}
