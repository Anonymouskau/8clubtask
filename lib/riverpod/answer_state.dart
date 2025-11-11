import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerState {
  final bool isAudioRecording;
  final bool isVideoRecording;
  final bool hasAudio;
  final bool hasVideo;

  AnswerState({
    this.isAudioRecording = false,
    this.isVideoRecording = false,
    this.hasAudio = false,
    this.hasVideo = false,
  });

  AnswerState copyWith({
    bool? isAudioRecording,
    bool? isVideoRecording,
    bool? hasAudio,
    bool? hasVideo,
  }) {
    return AnswerState(
      isAudioRecording: isAudioRecording ?? this.isAudioRecording,
      isVideoRecording: isVideoRecording ?? this.isVideoRecording,
      hasAudio: hasAudio ?? this.hasAudio,
      hasVideo: hasVideo ?? this.hasVideo,
    );
  }
}

class AnswerController extends StateNotifier<AnswerState> {
  AnswerController() : super(AnswerState());

  void startAudio() => state = state.copyWith(isAudioRecording: true);
  void stopAudio() => state = state.copyWith(isAudioRecording: false, hasAudio: true);
  void deleteAudio() => state = state.copyWith(hasAudio: false);

  void startVideo() => state = state.copyWith(isVideoRecording: true);
  void stopVideo() => state = state.copyWith(isVideoRecording: false, hasVideo: true);
  void deleteVideo() => state = state.copyWith(hasVideo: false);
}

final answerProvider = StateNotifierProvider<AnswerController, AnswerState>(
  (ref) => AnswerController(),
);
