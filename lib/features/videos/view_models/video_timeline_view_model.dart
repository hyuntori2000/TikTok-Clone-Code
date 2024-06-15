import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/%08videos/models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];

  void uploadVideo() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));
    final newVideo = VideoModel(title: "${DateTime.now()}");
    _list = [..._list, newVideo];
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 5));

    return _list;
  }
} // on build method we call the api that we need (List on the code), after received the data we return the data and Provider will expose the data.

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
