import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:client/component/custom_app_bar.dart';
import 'package:client/component/style/box_shadow_style.dart';
import 'package:client/constant/color.dart';
import 'package:client/constant/enum/who_talking.dart';
import 'package:client/notifier/avatar_select_view/avatar_select_view_notifier.dart';
import 'package:client/notifier/interview_view/interview_view_notifier.dart';
import 'package:client/view/interview_analytics/interview_analytics_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// 面談画面
class InterviewView extends ConsumerStatefulWidget {
  const InterviewView({super.key});

  @override
  ConsumerState<InterviewView> createState() => _InterviewView();
}

class _InterviewView extends ConsumerState<InterviewView> {
  @override
  void initState() {
    super.initState();
    Future(() async {
      final notifier = ref.read(interviewViewNotifierProvider.notifier);
      final teacherId = ref.watch(avatarSelectViewNotifierProvider
          .select((value) => value.selectedTeacherId));
      await notifier.startInterview(teacherId: teacherId);
    });
  }

  @override
  Widget build(BuildContext context) {
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
    final state = ref.watch(interviewViewNotifierProvider);
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: ColorDefinitions.primaryColor,
      appBar: CustomAppBar().startAppBar(context),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  const AssetImage('assets/image/interview_background_img.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.1),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  height: screenHeight * 0.5,
                  child: Image.asset('assets/image/sample_avatar.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 50),
                    // アバターのセリフ
                    _avatarChatBubble(state.avatarMessage),
                    const SizedBox(height: 4),
                    // ユーザーのセリフ
                    _userChatBubble(state.userMessage),
                    const SizedBox(height: 24),
                    // マイクボタン
                    _micButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ユーザーチャットの吹き出しUIを生成するWidget
  ///
  /// [text] 話した内容を持つ
  Widget _userChatBubble(String text) {
    return Align(
      alignment: Alignment.centerRight,
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
    );
  }

  /// アバターチャットの吹き出しUIを生成するWidget
  ///
  /// [text] 話した内容を持つ
  Widget _avatarChatBubble(String text) {
    final state = ref.watch(interviewViewNotifierProvider);
    return Align(
      alignment: Alignment.centerLeft,
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
        child: state.isLoading
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
    );
  }

  /// マイクボタンを生成するWidget
  Widget _micButton() {
    final notifier = ref.read(interviewViewNotifierProvider.notifier);
    final state = ref.watch(interviewViewNotifierProvider);
    return Opacity(
      opacity: state.whoTalking == WhoTalking.avatar ? 0.5 : 1.0,
      child: Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: notifier.micColor(state.whoTalking),
          shape: BoxShape.circle,
        ),
        child: AvatarGlow(
          animate: state.whoTalking == WhoTalking.user ? true : false,
          glowColor: ColorDefinitions.accentColor,
          glowRadiusFactor: state.whoTalking == WhoTalking.user ? 0.7 : 0.0,
          child: IconButton(
            icon: Icon(
              notifier.micIcon(state.whoTalking),
              color: Colors.white,
              size: state.whoTalking == WhoTalking.user ? 30 : 20,
            ),
            onPressed: () async {
              await notifier.micButtonTapAction();
            },
          ),
        ),
      ),
    );
  }
}
