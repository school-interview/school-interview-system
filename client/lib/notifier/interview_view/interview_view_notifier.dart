import 'package:client/app.dart';
import 'package:client/constant/result.dart';
import 'package:client/core/logger.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/interview/interview_repository.dart';
import 'package:client/repository/interview/interview_repository_impl.dart';
import 'package:client/view/interview/interview_view_state.dart';
import 'package:openapi/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'interview_view_notifier.g.dart';

@riverpod
class InterviewViewNotifier extends _$InterviewViewNotifier {
  @override
  InterviewViewState build() {
    return const InterviewViewState();
  }

  final InterviewRepository _interviewRepository = InterviewRepositoryImpl();

  void setAvatarSpeech(String avatarSpeech) {
    state = state.copyWith(avatarSpeech: avatarSpeech);
  }

  void setUserSpeech(String userSpeech) {
    state = state.copyWith(userSpeech: userSpeech);
  }

  void setIsTalking(bool isTalking) {
    state = state.copyWith(isTalking: isTalking);
  }

  void setStartInterviewResponse(
      StartInterviewResponse startInterviewResponse) {
    state = state.copyWith(startInterviewResponse: startInterviewResponse);
  }

  void setResult(Result result) {
    state = state.copyWith(result: result);
  }

  final SpeechToText _speechToText = SpeechToText();

  /// 初回処理
  Future<void> init({required String userId}) async {
    final requestId =
        InterviewSessionRequest(userId: userId, teacherId: "teacherId");

    try {
      ApiResult<StartInterviewResponse> response =
          await _interviewRepository.postInterviewSessionRequest(requestId);
      switch (response.statusCode) {
        case 200:
          setAvatarSpeech(response.data!.messageFromTeacher);
          setStartInterviewResponse(response.data!);
          setResult(Result.success);
          break;
        default:
          setResult(Result.putUserInformationError);
          break;
      }
      logger.exit(message: "responseData:${response.data}");
    } on Exception catch (e) {
      logger.error(message: e.toString());
      setResult(Result.putUserInformationError);
      logger.exit();
      return;
    }
  }

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
