import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';

class SASAudioService {
  // AudioCache audioCache = AudioCache();
  // AudioPlayer advancedPlayer = AudioPlayer();

  void initAudio() {
    if (Platform.isIOS) {
      // audioCache.fixedPlayer?.notificationService.startHeadlessService();
      // advancedPlayer.notificationService.startHeadlessService();
    }
  }

  void disposeAudio() {
    // advancedPlayer.dispose();
  }

  void playAudio() {
    // audioCache.play('glass.wav', mode: PlayerMode.LOW_LATENCY);
  }
}
