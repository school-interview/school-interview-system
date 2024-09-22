import 'package:client/view/interview/interview_view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'interview_view_notifier.g.dart';

@riverpod
class InterviewViewNotifier extends _$InterviewViewNotifier {
  @override
  InterviewViewState build() {
    return const InterviewViewState();
  }

  void setAvatarSpeech(String avatarSpeech) {
    state = state.copyWith(avatarSpeech: avatarSpeech);
  }

  void setUserSpeech(String userSpeech) {
    state = state.copyWith(userSpeech: userSpeech);
  }

  void setIsTalking(bool isTalking) {
    state = state.copyWith(isTalking: isTalking);
  }

  final SpeechToText _speechToText = SpeechToText();

  /// ユーザーが話し始めたときの処理
  Future<void> startTalking() async {
    var available = await _speechToText.initialize();
    if (available) {
      _speechToText.listen(onResult: (result) {
        setUserSpeech(result.recognizedWords);
      });
      setIsTalking(true);
    }
  }

  /// ユーザーが話し終えたときの処理
  void stopTalking() {
    _speechToText.stop();
    setIsTalking(false);
  }
}
