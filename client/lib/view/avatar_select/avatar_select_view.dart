import 'package:client/component/button_component.dart';
import 'package:client/component/custom_app_bar.dart';
import 'package:client/component/style/box_shadow_style.dart';
import 'package:client/constant/color.dart';
import 'package:client/generated/l10n.dart';
import 'package:client/notifier/avatar_select_view/avatar_select_view_notifier.dart';
import 'package:client/ui_core/image_network_manager.dart';
import 'package:client/view/interview/interview_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// アバター選択画面
class AvatarSelectView extends ConsumerStatefulWidget {
  const AvatarSelectView({super.key});

  @override
  ConsumerState<AvatarSelectView> createState() => _AvatarSelectView();
}

class _AvatarSelectView extends ConsumerState<AvatarSelectView> {
  @override
  void initState() {
    super.initState();
    Future(() async {
      final notifier = ref.read(avatarSelectViewNotifierProvider.notifier);
      await notifier.getTeacherList();
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
    final state = ref.watch(avatarSelectViewNotifierProvider);
    final notifier = ref.read(avatarSelectViewNotifierProvider.notifier);
    // Exception対策（なくても動作は問題ない）
    final scrollController = ScrollController();

    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: GridView.builder(
          itemCount: state.teacherCount,
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
              avatarName: state.teacherList[index].name,
              onTapSelectBox: () {
                // セレクトボックスをタップした時の処理
                notifier.setSelectedTeacherId(state.teacherList[index].id);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => _avatarDialog(
                    avatarName: state.teacherList[index].name,
                    image: "https://cdn2.thecatapi.com/images/adb.jpg",
                    selectedTeacherId: state.teacherList[index].id,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  /// アバターセレクトボックスを生成するWidget
  Widget _avatarSelectBox({
    required String avatarName,
    required Function() onTapSelectBox,
  }) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("ここに画像"),
              const SizedBox(height: 8),
              Text(avatarName),
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
    required String selectedTeacherId,
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
                      ButtonComponent().normalButton(
                        labelText: "面談開始",
                        onTapButton: () {
                          final notifier = ref
                              .read(avatarSelectViewNotifierProvider.notifier);
                          notifier.setSelectedTeacherId(selectedTeacherId);
                          // 面談画面へ遷移
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const InterviewView();
                            }),
                          );
                        },
                      )
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
