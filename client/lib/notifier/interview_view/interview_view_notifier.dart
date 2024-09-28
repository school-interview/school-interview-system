import 'package:client/app.dart';
import 'package:client/constant/enum/who_talking.dart';
import 'package:client/constant/result.dart';
import 'package:client/core/text_to_speech.dart';
import 'package:client/infrastructure/shared_preference_manager.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/interview/interview_repository.dart';
import 'package:client/repository/interview/interview_repository_impl.dart';
import 'package:client/view/interview/interview_view_state.dart';
import 'package:flutter/material.dart';
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

  void setResult(Result result) {
    state = state.copyWith(result: result);
  }

  void setIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setWhoTalking(WhoTalking whoTalking) {
    state = state.copyWith(whoTalking: whoTalking);
  }

  void setAvatarMessage(String avatarMessage) {
    state = state.copyWith(avatarMessage: avatarMessage);
  }

  void setUserMessage(String userMessage) {
    state = state.copyWith(userMessage: userMessage);
  }

  void setCurrentInterviewSessionId(String currentInterviewSessionId) {
    state =
        state.copyWith(currentInterviewSessionId: currentInterviewSessionId);
  }

  final SpeechToText _speechToText = SpeechToText();

  final InterviewRepository _interviewRepository = InterviewRepositoryImpl();

  final SharedPreferenceManager _sharedPreferenceManager =
      SharedPreferenceManager();

  /// 初回処理
  /// 面談を開始する
  Future<void> startInterview({
    required String teacherId,
  }) async {
    try {
      final userId =
          await _sharedPreferenceManager.getString(PrefKeys.userId) ?? "";
      final requestId =
          InterviewSessionRequest(userId: userId, teacherId: teacherId);
      ApiResult<StartInterviewResponse> response =
          await _interviewRepository.postInterviewSessionRequest(requestId);
      switch (response.statusCode) {
        case 200:
          setIsLoading(false);
          setAvatarMessage(response.data!.messageFromTeacher);
          setCurrentInterviewSessionId(response.data!.interviewSession.id);
          setResult(Result.success);
          TextToSpeech.speak(
            response.data!.messageFromTeacher,
            startFunc: () {
              setWhoTalking(WhoTalking.avatar);
            },
            endFunc: () {
              setWhoTalking(WhoTalking.none);
            },
          );
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

  /// マイクボタンタップ時のアクション
  Future<void>? micButtonTapAction() async {
    switch (state.whoTalking) {
      case WhoTalking.user:
        return _stopTalking();
      case WhoTalking.avatar:
        return;
      case WhoTalking.none:
        return _startTalking();
    }
  }

  /// ユーザーが話し始めたときの処理
  Future<void> _startTalking() async {
    setUserMessage("");
    setWhoTalking(WhoTalking.user);
    var available = await _speechToText.initialize();
    if (available) {
      _speechToText.listen(
        onResult: (result) {
          setUserMessage(result.recognizedWords);
        },
      );
    }
  }

  /// ユーザーが話し終えたときの処理
  Future<void> _stopTalking() async {
    setIsLoading(true);
    _speechToText.stop();
    setWhoTalking(WhoTalking.avatar);
    await _speakToTeacher(
      currentInterviewSessionId: state.currentInterviewSessionId,
      userSpeech: state.userMessage,
    );
  }

  /// 教員メッセージ取得API
  Future<void> _speakToTeacher({
    required String currentInterviewSessionId,
    required String userSpeech,
  }) async {
    logger.i("run speakToTeacher()");
    final speakToTeacherRequest =
        SpeakToTeacherRequest(messageFromStudent: userSpeech);
    try {
      ApiResult<TeacherResponse> response =
          await _interviewRepository.getMessageFromTeacher(
        currentInterviewSessionId,
        speakToTeacherRequest,
      );
      switch (response.statusCode) {
        case 200:
          setIsLoading(false);
          setAvatarMessage(response.data!.messageFromTeacher);
          setCurrentInterviewSessionId(response.data!.interviewSession.id);
          TextToSpeech.speak(
            response.data!.messageFromTeacher,
            startFunc: () {
              setWhoTalking(WhoTalking.avatar);
            },
            endFunc: () {
              setWhoTalking(WhoTalking.none);
            },
          );
          break;
        default:
          setAvatarMessage("エラーが発生しました");
          break;
      }
      logger.t("responseData:${response.data}");
    } on Exception catch (e) {
      logger.e(e.toString());
      return;
    }
  }

  /// マイクボタンのカラー
  Color? micColor(WhoTalking whoTalking) {
    switch (whoTalking) {
      case WhoTalking.user:
        return Colors.red;
      case WhoTalking.avatar:
        return Colors.grey;
      case WhoTalking.none:
        return Colors.blue[200];
      default:
        return null;
    }
  }

  /// マイクボタンのアイコン
  IconData? micIcon(WhoTalking whoTalking) {
    switch (whoTalking) {
      case WhoTalking.user:
        return Icons.stop;
      case WhoTalking.avatar:
        return Icons.mic_none;
      case WhoTalking.none:
        return Icons.mic;
      default:
        return null;
    }
  }
}
