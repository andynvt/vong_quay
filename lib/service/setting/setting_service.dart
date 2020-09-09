import 'package:flutter/material.dart';
import 'package:vong_quay/service/audio_player/audio_player.dart';
import 'package:vong_quay/service/cache/cache_service.dart';

class SettingService extends ChangeNotifier {
  bool isMute = false;

  SettingService() {
    restoreSetting();
  }

  void setMute() {
    isMute = !isMute;
    CacheService.shared().setBool('isMute', isMute);
    _setMute();
    notifyListeners();
  }

  void restoreSetting() async {
    isMute = CacheService.shared().getBool('isMute');
    print(isMute);
    _setMute();
    notifyListeners();
  }

  void _setMute() {
    if (isMute) {
      AudioPlayerService.shared().mute();
    } else {
      AudioPlayerService.shared().unMute();
    }
  }
}
