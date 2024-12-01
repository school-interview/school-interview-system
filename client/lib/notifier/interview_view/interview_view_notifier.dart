import 'package:camera/camera.dart';
import 'package:client/app.dart';
import 'package:client/constant/enum/who_talking.dart';
import 'package:client/constant/result.dart';
import 'package:client/core/text_to_speech.dart';
import 'package:client/infrastructure/shared_preference_manager.dart';
import 'package:client/model/chat_history.dart';
import 'package:client/repository/api_result.dart';
import 'package:client/repository/interview/interview_repository.dart';
import 'package:client/repository/interview/interview_repository_impl.dart';
import 'package:client/view/interview/interview_view_state.dart';
import 'package:file_saver/file_saver.dart';
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

  void setIsLoadUnity(bool isLoadUnity) {
    state = state.copyWith(isLoadUnity: isLoadUnity);
  }

  void setIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void _setWhoTalking(WhoTalking whoTalking) {
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

  void _setInterviewAnalytics(InterviewAnalytics interviewAnalytics) {
    state = state.copyWith(interviewAnalytics: interviewAnalytics);
  }

  void _setIsFinishInterview(bool isFinishInterview) =>
      state = state.copyWith(isFinishInterview: isFinishInterview);

  /// チャット履歴のリストに新しいチャットを追加する
  void _addChatHistories(ChatHistory chatHistory) => state =
      state.copyWith(chatHistories: [...state.chatHistories, chatHistory]);

  final SpeechToText _speechToText = SpeechToText();

  final InterviewRepository _interviewRepository = InterviewRepositoryImpl();

  final SharedPreferenceManager _sharedPreferenceManager =
      SharedPreferenceManager();

  /// 面談を開始する
  Future<void> _startInterview({
    required String teacherId,
  }) async {
    try {
      final userId =
          await _sharedPreferenceManager.getString(PrefKeys.userId) ?? "";
      final idToken =
          await _sharedPreferenceManager.getString(PrefKeys.idToken) ?? "";
      final requestId =
          InterviewSessionRequest(userId: userId, teacherId: teacherId);
      ApiResult<StartInterviewResponse> response = await _interviewRepository
          .postInterviewSessionRequest(requestId, idToken);
      switch (response.statusCode) {
        case 200:
          setIsLoading(false);
          setAvatarMessage(response.data!.messageFromTeacher);
          setCurrentInterviewSessionId(response.data!.interviewSession.id);
          setResult(Result.success);
          TextToSpeech.speak(
            response.data!.messageFromTeacher,
            startFunc: () {
              _setWhoTalking(WhoTalking.avatar);
            },
            endFunc: () {
              _setWhoTalking(WhoTalking.none);
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

  /// 教員メッセージ取得API
  Future<void> _speakToTeacher(
    CameraController cameraController, {
    required String currentInterviewSessionId,
    required String userSpeech,
  }) async {
    final speakToTeacherRequest =
        SpeakToTeacherRequest(messageFromStudent: userSpeech);
    try {
      final idToken =
          await _sharedPreferenceManager.getString(PrefKeys.idToken) ?? "";
      ApiResult<TeacherResponse> response =
          await _interviewRepository.getMessageFromTeacher(
        currentInterviewSessionId,
        speakToTeacherRequest,
        idToken,
      );
      switch (response.statusCode) {
        case 200:
          setIsLoading(false);
          setAvatarMessage(response.data!.messageFromTeacher);
          setCurrentInterviewSessionId(response.data!.interviewSession.id);
          _avatarTaking(cameraController,
              message: response.data!.messageFromTeacher,
              isFinish: response.data!.interviewSession.done);
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

  /// 要支援レベル取得API
  Future<void> _getInterviewAnalytics(
    String currentInterviewSessionId,
  ) async {
    try {
      final idToken =
          await _sharedPreferenceManager.getString(PrefKeys.idToken) ?? "";
      ApiResult<InterviewAnalytics> response = await _interviewRepository
          .getInterviewAnalytics(currentInterviewSessionId, idToken);
      switch (response.statusCode) {
        case 200:
          _setInterviewAnalytics(response.data!);
          break;
        default:
          // TODO 失敗時処理
          break;
      }
      logger.t("responseData:${response.data}");
      logger.t("interviewAnalytics:${state.interviewAnalytics}");
    } on Exception catch (e) {
      logger.e(e.toString());
      return;
    }
  }

  /// 初回処理
  Future<void> init(CameraController cameraController, String teacherId) async {
    await cameraController.startVideoRecording();
    await _teacherFirstMessage(teacherId);
  }

  /// アバターの最初のセリフを発言する
  Future<void> _teacherFirstMessage(String teacherId) async {
    await TextToSpeech.speak(
      state.avatarMessage,
      endFunc: () async {
        setIsLoading(true);
        // 面談を始める
        await _startInterview(teacherId: teacherId);
      },
    );
  }

  /// ユーザーが話し始めたときの処理
  Future<void> _startTalking() async {
    setUserMessage("");
    _setWhoTalking(WhoTalking.user);
    var available = await _speechToText.initialize();
    if (available) {
      _speechToText.listen(
        onResult: (result) {
          setUserMessage(result.recognizedWords);
        },
      );
    }
  }

  /// ユーザーのセリフをリセットしたときの処理
  Future<void> resetTalking() async {
    await _speechToText.stop();
    _setWhoTalking(WhoTalking.none);
    // [startTalking] の [_speechToText.listen] が
    // セリフリセット後にそれまで認識していたセリフを再セットしてしまう問題がありました
    // 技術力不足のため、強制的に2秒ディレイさせることで解決しています
    Future.delayed(const Duration(seconds: 2)).then((_) {
      setUserMessage("");
    });
  }

  /// ユーザーが話し終えたときの処理
  Future<void> _stopTalking(CameraController cameraController) async {
    setIsLoading(true);
    await _speechToText.stop();
    _setWhoTalking(WhoTalking.avatar);
    _addChatHistories(ChatHistory(state.avatarMessage, true));
    await _speakToTeacher(
      cameraController,
      currentInterviewSessionId: state.currentInterviewSessionId,
      userSpeech: state.userMessage,
    );
  }

  /// アバターが話す処理
  void _avatarTaking(
    CameraController cameraController, {
    required String message,
    required bool isFinish,
  }) {
    TextToSpeech.speak(
      message,
      startFunc: () {
        _setWhoTalking(WhoTalking.avatar);
        if (!isFinish) {
          // 面談が終了していない場合、チャット履歴を更新してユーザーのセリフをリセットする
          // 技術力不足により、強制的に1秒ディレイしています
          Future.delayed(const Duration(seconds: 1)).then((_) {
            _addChatHistories(ChatHistory(state.userMessage, false));
            setUserMessage("");
          });
        }
      },
      endFunc: () async {
        _setWhoTalking(WhoTalking.none);
        // 面談が終了した場合、要支援レベルを取得する
        if (isFinish) {
          await _getInterviewAnalytics(state.currentInterviewSessionId);
          // 撮影した動画を保存する
          await _stopRecordingAndSaveVideo(cameraController);
          await cameraController.dispose();
          _setIsFinishInterview(true);
        }
      },
    );
  }

  /// 録画を停止し、撮影した動画を保存する
  Future<void> _stopRecordingAndSaveVideo(
      CameraController cameraController) async {
    final video = await cameraController.stopVideoRecording();
    final byte = await video.readAsBytes();
    await FileSaver.instance.saveFile(
        name: "${DateTime.now().millisecondsSinceEpoch}",
        bytes: byte,
        mimeType: MimeType.mp4Video);
  }

  /// マイクボタンタップ時のアクション
  Future<void>? micButtonTapAction(CameraController cameraController) async {
    switch (state.whoTalking) {
      case WhoTalking.user:
        return await _stopTalking(cameraController);
      case WhoTalking.avatar:
        return;
      case WhoTalking.none:
        return await _startTalking();
    }
  }
}
