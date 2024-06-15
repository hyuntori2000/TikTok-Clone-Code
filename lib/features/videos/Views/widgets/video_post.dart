import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/video_config/video_config.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/%08videos/Views/widgets/video_button.dart';
import 'package:tiktok_clone/features/%08videos/Views/widgets/video_comment.dart';
import 'package:tiktok_clone/features/%08videos/view_models/playback_config_viewmodel.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost(
      {super.key, required this.onVideoFinished, required this.index});

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/IMG_2721.mp4");

  bool _isPause = false;
  bool _fullCaption = false;
  bool _volumeOn = true;

  final String _videoCaption = "This is the new kobe 4!";

  final Duration _animatedDuration = const Duration(milliseconds: 200);

  late final AnimationController _animationController;

  late final PlaybackConfigViewModel _playbackConfigViewModel;
  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value
              .position) // it means when video's length is same as the user's time postion. it is also means the video is over.
      {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping((true));
    if (kIsWeb) {
      _videoPlayerController.setVolume(0);
      _volumeOn = false;
    } else {
      _volumeOn = !ref.watch(playbackConfigProvider).muted;
      _videoPlayerController.setVolume(_volumeOn ? 1 : 0);
    }
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});

    //method to make the video player start when we init the state and let the system know the video is there and play it.
  }

  @override
  void initState() {
    super.initState();

    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animatedDuration,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) return;

    if (!_volumeOn) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPause &&
        !_videoPlayerController.value.isPlaying) {
      if (ref.read(playbackConfigProvider).autoplay) {
        _videoPlayerController.play();
      }
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _ontogglePause();
    }
  }

  void _volumeOnOff() {
    setState(() {
      _volumeOn = !_volumeOn;
      _videoPlayerController.setVolume(_volumeOn ? 1 : 0);
    });
  }

  void _ontogglePause() {
    if (!mounted) return;
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPause = !_isPause;
    });
  }

  String _checkLongCaption() {
    return _videoCaption.length > 25
        ? "${_videoCaption.substring(0, 25)} ..."
        : _videoCaption;
  }

  void _onSeeMoreTap() {
    if (_fullCaption == false) {
      setState(() {
        _fullCaption = true;
      });
    }
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying == true) {
      _ontogglePause();
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const VIdeoComments(),
    );
    _ontogglePause();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _ontogglePause,
            ),
          ),
          Positioned.fill(
              child: IgnorePointer(
            child: Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                      scale: _animationController.value, child: child);
                }, // this part will work like a funciton. and setState.
                child: AnimatedOpacity(
                  opacity: _isPause ? 1 : 0,
                  duration: _animatedDuration,
                  child: const FaIcon(
                    FontAwesomeIcons.play,
                    color: Colors.white,
                    size: Sizes.size48,
                  ),
                ),
              ),
            ),
          )),
          Positioned(
            left: 20,
            top: 40,
            child: IconButton(
                icon: FaIcon(
                  !_volumeOn
                      ? FontAwesomeIcons.volumeOff
                      : FontAwesomeIcons.volumeHigh,
                  color: Colors.white,
                ),
                onPressed: _volumeOnOff),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "@nobody",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v20,
                Row(
                  children: [
                    Text(
                      _fullCaption ? _videoCaption : _checkLongCaption(),
                      style: const TextStyle(
                        fontSize: Sizes.size16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                    ),
                    if (_videoCaption.length > 25 && !_fullCaption)
                      GestureDetector(
                        onTap: _onSeeMoreTap,
                        child: const Text(
                          "See more",
                          style: TextStyle(
                            fontSize: Sizes.size16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 20,
              right: 10,
              child: Column(
                children: [
                  const CircleAvatar(
                    foregroundImage: NetworkImage(
                        "https://avatars.githubusercontent.com/u/131842228?v=4"),
                    radius: 25,
                    child: Text("JY"),
                  ),
                  Gaps.v20,
                  const VideoButton(
                    icon: FontAwesomeIcons.solidHeart,
                    text: "200",
                  ),
                  Gaps.v20,
                  GestureDetector(
                    onTap: () => _onCommentsTap(context),
                    child: const VideoButton(
                      icon: FontAwesomeIcons.solidComment,
                      text: "476",
                    ),
                  ),
                  Gaps.v20,
                  const VideoButton(
                    icon: FontAwesomeIcons.share,
                    text: "Share",
                  )
                ],
              ))
        ],
      ),
    );
  }
}
