import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/%08videos/models/playback_config_moddel.dart';
import 'package:tiktok_clone/features/%08videos/repositories/video_playback_config_repose.dart';

class PlaybackConfigViewModel extends ChangeNotifier {
  final VideoPlaybackConfigRepository _repository; // defining repository

  late final PlaybackConfigModel _model = PlaybackConfigModel(
      muted: _repository.isMuted(), autoplay: _repository.isAutoplay());

  PlaybackConfigViewModel(this._repository); // initializeing repository.

  bool get muted => _model.muted;
  bool get autoplay =>
      _model.autoplay; // in order to not expose the model and repository

  void setMuted(bool value) {
    _repository.setMuted(value); // persist data
    _model.muted = value; //Modify the data
    notifyListeners(); // by using this method view will request to this viewmodel to set data and this view model will tell model to set data or bring data.
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    _model.autoplay = value;
    notifyListeners();
  }
}
