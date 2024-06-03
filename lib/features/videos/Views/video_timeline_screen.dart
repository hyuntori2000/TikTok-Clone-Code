import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/%08videos/Views/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  final PageController _pageController = PageController();
  final Duration _scrollDuration = const Duration(milliseconds: 100);
  final Curve _scrollCurve = Curves.linear;
  int _itemCount = 4;

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;

      setState(() {});
    }
  }

  void _onVideoFinished() {
    return;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Future.delayed(
      const Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      backgroundColor: Colors.white,
      edgeOffset: 10,
      displacement: 50,
      onRefresh:
          _onRefresh, //it whould retrun future, indicator will stay until future gone.
      child: PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          pageSnapping: true, //스코롤이 자동으로 안넘어가게 하는것.

          scrollDirection:
              Axis.vertical, //원래는 horizontal이나 이렇게하면 from top to bottom.
          itemCount: _itemCount,
          itemBuilder: (context, index) =>
              VideoPost(onVideoFinished: _onVideoFinished, index: index)),
    );
  }
}
