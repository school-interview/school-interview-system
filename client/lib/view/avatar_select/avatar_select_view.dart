import 'package:client/component/custom_app_bar.dart';
import 'package:client/component/style/box_shadow_style.dart';
import 'package:client/constant/color.dart';
import 'package:client/generated/l10n.dart';
import 'package:client/ui_core/image_network_manager.dart';
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
      appBar: CustomAppBar().startAppBar(context),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text(
                S.of(context).avatarSelectDescription,
                style: const TextStyle(color: ColorDefinitions.textColor),
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
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => _avatarDialog(
                          avatarName: "名前",
                          image: "https://cdn2.thecatapi.com/images/adb.jpg"));
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
              Text("ここに画像"),
              SizedBox(height: 8),
              Text("アバター名"),
            ],
          ),
        ),
      ),
    );
  }

  /// アバター選択時に表示するダイアログ
  Widget _avatarDialog({
    required String avatarName,
    required String image,
  }) {
    return Dialog(
      insetPadding:
          const EdgeInsets.only(top: 40, right: 16, bottom: 32, left: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                size: 24,
              ),
            ),
          ]),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // TODO アバターの画像と名前の表示レイアウト要修正
                      const SizedBox(height: 8),
                      ImageNetworkManager(
                        iconUrl: image,
                      ),
                      const SizedBox(height: 8),
                      Text(avatarName),
                      const SizedBox(height: 8),
                      Text(S.of(context).avatarDialogDescription),
                      const SizedBox(height: 8),
                      // 面談画面へ遷移するボタン
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: ColorDefinitions.accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('面談開始'),
                        onPressed: () {
                          // 面談画面へ遷移
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
