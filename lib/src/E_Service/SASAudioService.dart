import 'dart:io';

import 'Base/SABBaseService.dart';

// import 'package:audioplayers/audioplayers.dart';

class SASAudioService extends SABBaseService {
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
