import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vong_quay/service/cache/cache_service.dart';

class AudioPlayerService {
  static AudioPlayerService _sInstance;
  AudioCache cache = AudioCache();
  AudioPlayer _player = AudioPlayer();
  double _volume = 0.0;

  AudioPlayerService._() {
    _initPlayer();
  }

  factory AudioPlayerService.shared() {
    if (_sInstance == null) {
      _sInstance = AudioPlayerService._();
    }
    return _sInstance;
  }

  void _initPlayer() {
    _player = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER, playerId: 'vq_player_id');
    _volume = CacheService.shared().getDouble('volume');
    _player.setVolume(_volume);
  }

  void playSpin() async {
    _player = await cache.play('audios/spin.mp3', volume: _volume);
  }

  void playCongrats() async {
    _player = await cache.play('audios/congrats1.mp3', volume: _volume);
  }

  void playVoice(String wheelIndex, int itemIndex) async {
    _player = await cache
        .play(
      'audios/done.mp3',
      volume: _volume,
    )
        .then((_) {
      return Future.delayed(Duration(milliseconds: 300), () async {
        return _player = await cache.play(
          'audios/$wheelIndex$itemIndex.mp3',
          volume: _volume,
        );
      });
    });
  }

  void stop() async {
    await _player.stop();
  }

  void mute() {
    _volume = 0.0;
    CacheService.shared().setDouble('volume', _volume);
    _player.setVolume(_volume);
  }

  void unMute() {
    _volume = 1.0;
    CacheService.shared().setDouble('volume', _volume);
    _player.setVolume(_volume);
  }
}
