import 'package:avatar_glow/avatar_glow.dart';
import 'package:client/component/custom_app_bar.dart';
import 'package:client/component/style/box_shadow_style.dart';
import 'package:client/constant/color.dart';
import 'package:client/notifier/avatar_select_view/avatar_select_view_notifier.dart';
import 'package:client/notifier/interview_view/interview_view_notifier.dart';
import 'package:client/notifier/profile_input_view/profile_input_view_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InterviewView extends ConsumerStatefulWidget {
  const InterviewView({super.key});

  @override
  ConsumerState<InterviewView> createState() => _InterviewView();
}

class _InterviewView extends ConsumerState<InterviewView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(interviewViewNotifierProvider.notifier);
      final userId = ref.watch(
          profileInputViewNotifierProvider.select((value) => value.user!.id));
      final teacherId = ref.watch(avatarSelectViewNotifierProvider
          .select((value) => value.selectedTeacherId));
      notifier.init(userId: userId, teacherId: teacherId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(interviewViewNotifierProvider);

    return Scaffold(
      backgroundColor: ColorDefinitions.primaryColor,
      appBar: CustomAppBar().startAppBar(context),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Image.asset('assets/image/sample_avatar.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 50),
                  // アバターのセリフ
                  _chatBubble(state.avatarSpeech, false),
                  const SizedBox(height: 4),
                  // ユーザーのセリフ
                  _chatBubble(state.userSpeech, true),
                  const SizedBox(height: 24),
                  // マイクボタン
                  _micButton()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// チャットの吹き出しUIを生成するWidget
  ///
  /// [text] 話した内容を持つ
  /// [isTalkByMe] 自分が話しているかどうかを判別する
  Widget _chatBubble(String text, bool isTalkByMe) {
    return Align(
      alignment: isTalkByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isTalkByMe ? Colors.green[100] : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: isTalkByMe
                  ? const Radius.circular(16)
                  : const Radius.circular(0),
              bottomRight: isTalkByMe
                  ? const Radius.circular(0)
                  : const Radius.circular(16),
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

  /// マイクボタンを生成するWidget
  Widget _micButton() {
    final notifier = ref.read(interviewViewNotifierProvider.notifier);
    final state = ref.watch(interviewViewNotifierProvider);

    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: state.isTalking ? Colors.red : Colors.blue[200],
        shape: BoxShape.circle,
      ),
      child: AvatarGlow(
        animate: state.isTalking ? true : false,
        glowColor: ColorDefinitions.accentColor,
        glowRadiusFactor: state.isTalking ? 0.7 : 0.0,
        child: IconButton(
          icon: Icon(
            state.isTalking ? Icons.stop : Icons.mic,
            color: Colors.white,
            size: state.isTalking ? 30 : 20,
          ),
          onPressed: () {
            state.isTalking ? notifier.stopTalking() : notifier.startTalking();
          },
        ),
      ),
    );
  }
}
