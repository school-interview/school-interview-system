import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:camera/camera.dart';
import 'package:client/app.dart';
import 'package:client/component/custom_app_bar.dart';
import 'package:client/component/style/box_shadow_style.dart';
import 'package:client/constant/color.dart';
import 'package:client/constant/enum/who_talking.dart';
import 'package:client/notifier/interview_view/interview_view_notifier.dart';
import 'package:client/ui_core/interview_mic_color.dart';
import 'package:client/view/interview_analytics/interview_analytics_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// 面談画面
class InterviewView extends ConsumerStatefulWidget {
  const InterviewView(
      {super.key, required this.cameraController, required this.teacherId});

  final CameraController cameraController;
  final String teacherId;

  @override
  ConsumerState<InterviewView> createState() => _InterviewView();
}

class _InterviewView extends ConsumerState<InterviewView> {
  UnityWidgetController? _unityWidgetController;

  @override
  void initState() {
    super.initState();
    Future(() async {
      final notifier = ref.read(interviewViewNotifierProvider.notifier);
      notifier.setAvatarMessage("こんにちは。これから面談を始めます。");
      // Unityの読み込み表示を見せないため、1秒強制ディレイさせる
      Future.delayed(const Duration(seconds: 1)).then((_) async {
        notifier.setIsLoadUnity(false);
        await notifier.init(widget.cameraController, widget.teacherId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 面談終了フラグを監視し、面談が終了した際の処理を制御する
    ref.listen<bool>(
        interviewViewNotifierProvider
            .select((value) => value.isFinishInterview), (_, next) {
      // 面談が終了、かつ面談結果データが存在していれば画面遷移する
      final state = ref.watch(interviewViewNotifierProvider);
      if (state.interviewAnalytics != null) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return InterviewAnalyticsView(
                interviewAnalytics: state.interviewAnalytics!);
          }),
        );
      } else {
        /// TODO 面談結果nullだった場合の処理を実装
        /// エラーダイアログを表示してログイン画面に戻る
      }
    });

    /// 誰が話している状態かを監視し、アバターの動きを制御する
    ref.listen<WhoTalking>(
        interviewViewNotifierProvider.select((value) => value.whoTalking),
        (_, next) {
      final state = ref.watch(interviewViewNotifierProvider);
      switch (state.whoTalking) {
        case WhoTalking.avatar:
          _setAvatarState("talk");
          break;
        default:
          _setAvatarState("nod");
      }
    });
    final state = ref.watch(interviewViewNotifierProvider);
    final screenHeight = MediaQuery.sizeOf(context).height;
    const avatarContainerWidth = 400.0;
    // Exception対策（なくても動作は問題ない）
    final scrollController = ScrollController();
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: ColorDefinitions.primaryColor,
        appBar: CustomAppBar().startAppBar(context),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(
                    'assets/image/interview_background_img.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.1),
                  BlendMode.dstATop,
                ),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Opacity(
                      opacity: state.isLoadUnity ? 0.1 : 1.0,
                      // 面談アバター
                      child: SizedBox(
                        height: screenHeight * 0.5,
                        width: avatarContainerWidth,
                        child: UnityWidget(
                          onUnityCreated: _onUnityCreated,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // マイクボタン
                    _micButton(),
                  ],
                ),

                /// Unity読み込み中の表示
                if (state.isLoadUnity)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      color: Colors.white,
                      height: screenHeight * 0.5,
                      width: avatarContainerWidth,
                      child: const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("面談相手を待っています..."),
                            SizedBox(height: 12),
                            CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    ColorDefinitions.accentColor)),
                          ],
                        ),
                      ),
                    ),
                  ),

                // チャット部分
                Container(
                  height: screenHeight * 0.4,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Scrollbar(
                    controller: scrollController,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      reverse: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // チャット履歴を表示する
                          for (var chat in state.chatHistories) ...[
                            if (chat.isAdmin) ...[
                              _AvatarChatBubble(
                                text: chat.text,
                                isLoading: false,
                              ),
                            ],
                            if (!chat.isAdmin) ...[
                              _UserChatBubble(text: chat.text),
                            ],
                          ],
                          // アバターのセリフ
                          _AvatarChatBubble(
                            text: state.avatarMessage,
                            isLoading: state.isLoading,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // セリフリセットボタン
                              IconButton(
                                // 教員が話しているときは非活性
                                onPressed: state.whoTalking == WhoTalking.avatar
                                    ? null
                                    : () async {
                                        // ユーザのセリフをリセットする
                                        final notifier = ref.watch(
                                            interviewViewNotifierProvider
                                                .notifier);
                                        await notifier.resetTalking();
                                      },
                                icon: const Icon(Icons.refresh),
                                style: IconButton.styleFrom(
                                    backgroundColor: Colors.white),
                              ),

                              const SizedBox(width: 10),
                              // ユーザーのセリフ
                              _UserChatBubble(text: state.userMessage),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 作成したコントローラをunityコントローラに接続するコールバック
  void _onUnityCreated(controller) {
    controller.resume();
    _unityWidgetController = controller;
  }

  /// アバターの状態をUnityへ送信する
  /// [flag] が"talk"のときアバターは話し始める
  /// [flag] が"talk"以外の文字列のときアバターはうなずき始める
  Future<void> _setAvatarState(String flag) async {
    if (_unityWidgetController == null) {
      logger.e("_unityWidgetController is null");
    } else {
      await _unityWidgetController?.postMessage(
        'hiyori_free_t08', // 対象GameObject
        'SetState', // Unityスクリプト内のメソッド名
        flag, // 送信するメッセージ
      );
    }
  }

  /// マイクボタンを生成するWidget
  Widget _micButton() {
    final state = ref.watch(interviewViewNotifierProvider);
    final interviewMic = InterviewMic(whoTalking: state.whoTalking);
    return Opacity(
      opacity: state.whoTalking == WhoTalking.avatar ? 0.5 : 1.0,
      child: Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: interviewMic.micColor,
          shape: BoxShape.circle,
        ),
        child: AvatarGlow(
          animate: state.whoTalking == WhoTalking.user ? true : false,
          glowColor: ColorDefinitions.accentColor,
          glowRadiusFactor: state.whoTalking == WhoTalking.user ? 0.7 : 0.0,
          child: IconButton(
            icon: Icon(
              interviewMic.micIcon,
              color: Colors.white,
              size: state.whoTalking == WhoTalking.user ? 30 : 20,
            ),
            onPressed: () async {
              final notifier = ref.read(interviewViewNotifierProvider.notifier);
              await notifier.micButtonTapAction(widget.cameraController);
            },
          ),
        ),
      ),
    );
  }
}

/// ユーザーチャットの吹き出しUIを生成するWidget
class _UserChatBubble extends StatelessWidget {
  const _UserChatBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: screenWidth * 0.6),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(0),
              ),
              boxShadow: BoxShadowStyle.chatBubbleShadowStyle()),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

/// アバターチャットの吹き出しUIを生成するWidget
class _AvatarChatBubble extends StatelessWidget {
  const _AvatarChatBubble({required this.text, required this.isLoading});

  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: screenWidth * 0.6),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              boxShadow: BoxShadowStyle.chatBubbleShadowStyle()),
          child: isLoading
              ? LoadingAnimationWidget.waveDots(
                  color: Colors.black87,
                  size: 16,
                )
              : DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TyperAnimatedText(
                        text,
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
