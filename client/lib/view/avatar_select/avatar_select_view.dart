import 'package:client/component/button_component.dart';
import 'package:client/component/custom_app_bar.dart';
import 'package:client/component/style/box_shadow_style.dart';
import 'package:client/constant/color.dart';
import 'package:client/generated/l10n.dart';
import 'package:client/notifier/avatar_select_view/avatar_select_view_notifier.dart';
import 'package:client/view/interview/interview_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
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
          controller: scrollController,
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
            final teacher = state.teacherList[index];
            return _avatarSelectBox(
              avatarName: teacher.name,
              onTapSelectBox: () async {
                String cautionContent =
                    await rootBundle.loadString('assets/cautions.html');
                // セレクトボックスをタップした時の処理
                notifier.setSelectedTeacherId(teacher.id);
                if (context.mounted) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) => _avatarDialog(
                      avatarName: teacher.name,
                      imageString: 'assets/image/sample_avatar.png',
                      selectedTeacherId: teacher.id,
                      cautionContent: cautionContent,
                    ),
                  );
                }
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
    required String imageString,
    required String selectedTeacherId,
    required String cautionContent,
  }) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    // Exception対策（なくても動作は問題ない）
    final scrollController = ScrollController();

    return Dialog(
      insetPadding:
          const EdgeInsets.only(top: 40, right: 16, bottom: 32, left: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: Colors.white,
      child: Scrollbar(
        thumbVisibility: true,
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close, size: 24),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                width: screenWidth * 0.4,
                child: Image.asset(imageString),
              ),
              Text(
                avatarName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Html(data: cautionContent),
              ),
              // 面談画面へ遷移するボタン
              Padding(
                padding: const EdgeInsets.all(20),
                child: ButtonComponent().normalButton(
                  labelText: "面談を開始する",
                  onTapButton: () {
                    final notifier =
                        ref.read(avatarSelectViewNotifierProvider.notifier);
                    notifier.setSelectedTeacherId(selectedTeacherId);
                    // 面談画面へ遷移
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const InterviewView();
                      }),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
