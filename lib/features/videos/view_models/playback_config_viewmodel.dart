import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/%08videos/models/playback_config_moddel.dart';
import 'package:tiktok_clone/features/%08videos/repositories/video_playback_config_repose.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final VideoPlaybackConfigRepository _repository; // defining repository

  PlaybackConfigViewModel(this._repository); // initializeing repository.

  void setMuted(bool value) {
    _repository.setMuted(value); // persist data
    state = PlaybackConfigModel(
        // creating new state.
        muted: value,
        autoplay: state
            .autoplay); // muted variable will follow the value it receive. and autoplay variable will keep the value in the previous state.
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(muted: state.muted, autoplay: value);
  }

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
        muted: _repository.isMuted(), autoplay: _repository.isAutoplay());
  }
} // in this build method it retruns initial data of the state.

// state can not be mutate. in order to change state. another state must be created.
final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(() =>
        throw UnimplementedError());//provider we want to expose is PlaybackConfigViewModel, and data we need is PlaybackConfigModel.
