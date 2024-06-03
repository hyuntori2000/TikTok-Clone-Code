class PlaybackConfigModel {
  bool muted;
  bool autoplay;

  PlaybackConfigModel({
    required this.muted,
    required this.autoplay,
  }); //construction which can traslate Json into api
}
