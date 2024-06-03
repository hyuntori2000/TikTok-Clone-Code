// presist(유지) data to disk and bring data from disk

import 'package:shared_preferences/shared_preferences.dart';

class VideoPlaybackConfigRepository {
  static const String _autoplay = "autoplay";
  static const String _muted = "muted";

  final SharedPreferences _preferences;

  VideoPlaybackConfigRepository(this._preferences);

  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoplay, value);
  }

  bool isMuted() {
    return _preferences.getBool(_muted) ??
        false; // 디스크에 정보가 없다면 false로 간주하겠다는 뜻
  }

  bool isAutoplay() {
    return _preferences.getBool(_autoplay) ?? false;
  }
}
