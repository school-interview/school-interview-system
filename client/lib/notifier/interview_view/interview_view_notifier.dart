import 'package:client/app.dart';
import 'package:client/constant/result.dart';
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

  void setCurrentInterviewSession(InterviewSession interviewSession) {
    state = state.copyWith(currentInterviewSession: interviewSession);
  }

  void setResult(Result result) {
    state = state.copyWith(result: result);
  }

  void setTeachers(List<Teacher> teachers) {
    state = state.copyWith(teachers: teachers);
  }

  final SpeechToText _speechToText = SpeechToText();

  /// 初回処理
  Future<void> init({
    required String userId,
    required String teacherId,
  }) async {
    try {
      final requestId =
          InterviewSessionRequest(userId: userId, teacherId: teacherId);

      ApiResult<StartInterviewResponse> response =
          await _interviewRepository.postInterviewSessionRequest(requestId);
      switch (response.statusCode) {
        case 200:
          setAvatarSpeech(response.data!.messageFromTeacher);
          setStartInterviewResponse(response.data!);
          setCurrentInterviewSession(response.data!.interviewSession);
          setResult(Result.success);
          logger.t("responseData:${response.data}");
          break;
        default:
          setResult(Result.fail);
          break;
      }
    } on Exception catch (e) {
      setResult(Result.fail);
      logger.e(e.toString());
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
    _speakToTeacher(
        state.startInterviewResponse!.interviewSession, state.userSpeech);
  }

  Future<void> _speakToTeacher(
      InterviewSession interviewSession, String text) async {
    logger.i("run speakToTeacher()");
    final speakToTeacherRequest =
        SpeakToTeacherRequest(messageFromStudent: text);
    try {
      ApiResult<TeacherResponse> response = await _interviewRepository
          .getMessageFromTeacher(interviewSession.id, speakToTeacherRequest);
      switch (response.statusCode) {
        case 200:
          setAvatarSpeech(response.data!.messageFromTeacher);
          setCurrentInterviewSession(response.data!.interviewSession);
          break;
        default:
          setAvatarSpeech("エラーが発生しました");
          break;
      }
      logger.t("responseData:${response.data}");
    } on Exception catch (e) {
      logger.e(e.toString());
      return;
    }
  }
}
