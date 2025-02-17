import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:client/app.dart';
import 'package:client/component/button_component.dart';
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
      await notifier.getAvatarList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(avatarSelectViewNotifierProvider);
    // Exception対策（なくても動作は問題ない）
    final scrollController = ScrollController();
    return Scaffold(
      backgroundColor: ColorDefinitions.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorDefinitions.secondaryColor,
        title: Text(S.of(context).startAppBarTitle),
        titleTextStyle: const TextStyle(
          color: ColorDefinitions.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      body: Stack(children: [
        IgnorePointer(
          ignoring: state.isLoading,
          child: Opacity(
            opacity: state.isLoading ? 0.1 : 1.0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        S.of(context).avatarSelectDescription,
                        style:
                            const TextStyle(color: ColorDefinitions.textColor),
                      ),
                      const SizedBox(height: 16),

                      /// アバター一覧を生成する
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: GridView.builder(
                          controller: scrollController,
                          itemCount: state.avatarCount,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 180,
                          ),
                          itemBuilder: (context, index) {
                            final teacher = state.avatarList[index];
                            return _AvatarSelectBox(
                              avatarName: teacher.name,
                              onTapSelectBox: () async {
                                // 注意書きを取得
                                String cautionContent = await rootBundle
                                    .loadString('assets/cautions.html');
                                if (context.mounted) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) =>
                                        _avatarDialog(
                                      avatarName: teacher.name,
                                      imageString:
                                          'assets/image/sample_avatar.png',
                                      cautionContent: cautionContent,
                                      teacherId: teacher.id,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (state.isLoading)
          const Align(
            child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(ColorDefinitions.accentColor)),
          ),
      ]),
    );
  }

  /// アバター選択時に表示するダイアログ
  Widget _avatarDialog({
    required String avatarName,
    required String imageString,
    required String cautionContent,
    required String teacherId,
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
                  onTapButton: () async {
                    // ダイアログを閉じる
                    Navigator.of(context).pop();
                    // インジケーターを表示
                    final notifier =
                        ref.read(avatarSelectViewNotifierProvider.notifier);
                    notifier.setIsLoading(true);
                    // カメラとマイクを初期化（使用許可をとる）
                    try {
                      final cameras = await availableCameras();
                      CameraController cameraController =
                          CameraController(cameras.first, ResolutionPreset.max);
                      await cameraController.initialize();
                      // 面談画面へ遷移
                      if (mounted) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return InterviewView(
                                cameraController: cameraController,
                                teacherId: teacherId);
                          }),
                        );
                      }
                    } catch (e) {
                      logger.e("failed camera initialize:$e");
                      if (mounted) {
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.topSlide,
                            dialogBackgroundColor: Colors.white,
                            title: "カメラ、もしくはマイクが使用できません。",
                            desc: "お使いのブラウザの設定を見直してどちらも使用が許可されていることを確認してください。",
                            btnCancelText: "ログインに戻る",
                            btnCancelOnPress: () {
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            },
                            btnOkText: "確認",
                            btnOkOnPress: () {
                              null;
                            }).show();
                      }
                    }
                    // インジケーターを非表示
                    notifier.setIsLoading(false);
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

/// アバターセレクトボックスを生成するWidget
class _AvatarSelectBox extends StatelessWidget {
  const _AvatarSelectBox({
    required this.avatarName,
    required this.onTapSelectBox,
  });

  final String avatarName;
  final Function() onTapSelectBox;

  @override
  Widget build(BuildContext context) {
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: Image.asset("assets/image/sample_avatar.png"),
              ),
              const SizedBox(height: 8),
              Text(avatarName),
            ],
          ),
        ),
      ),
    );
  }
}
