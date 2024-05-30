import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/%08videos/video_preview_screen.dart';
import 'package:tiktok_clone/features/%08videos/widgets/%08flash_button.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const routeName = "videoRecording";
  static const routeUrl = "/upload";
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool get isCameraControllerInitialized =>
      _cameraController.value.isInitialized;

  final double _initZoomLevel = 1.0;

  double _currentZoomLevel = 1.0;

  late final bool _noCamera = kDebugMode && Platform.isIOS;
  double _maxZoomLevel = 1.0;
  bool _hasPermission = false;
  bool _deniedPermission = false;
  bool _isSelfieMode = false;
  bool _isCameraInitialized = false;
  bool _isRecording = false;
  late CameraController _cameraController;
  late FlashMode _flashMode;
  late final AnimationController _buttonanimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200));
  late final AnimationController _timerAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  late final Animation<double> _buttonAnimation = Tween(
    begin: 1.0,
    end: 1.3,
  ).animate(_buttonanimationController);

  Future<void> initCamera() async {
    final cameras =
        await availableCameras(); // this will give lists of all camera.
    if (cameras.isEmpty) {
      return;
    } //만약에 카메라를 인식하지 못했을경우 실행을 중단한다.
    _cameraController = CameraController(
        cameras[_isSelfieMode ? 1 : 0], ResolutionPreset.ultraHigh);

    await _cameraController.initialize();

    _maxZoomLevel = await _cameraController.getMaxZoomLevel();

    _flashMode = _cameraController.value.flashMode;

    await _cameraController
        .prepareForVideoRecording(); //This is for ios, to get right sink between audio and video
    setState(() {
      _isCameraInitialized = true;
    });
  }

  void disposeCamera() async {
    if (_cameraController.value.isInitialized) {
      await _cameraController.dispose();
      setState(() {
        _isCameraInitialized = false;
      });
    }
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final microphonePermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied = microphonePermission.isDenied ||
        microphonePermission.isPermanentlyDenied;
    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    } else {
      _deniedPermission = true;
      setState(() {});
    }
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
    }
    setState(() {
      _hasPermission = true;
    });

    WidgetsBinding.instance.addObserver(this);

    _timerAnimationController.addListener(() {
      setState(() {});
    });
    _timerAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  Future<void> _toggleSelphieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera(); // after changeing the cameramode we should initialize the camera again.
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo == true) {
      return;
    }
    await _cameraController.startVideoRecording();

    _buttonanimationController.forward();
    _timerAnimationController.forward();
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;
    _buttonanimationController.reverse();
    _timerAnimationController.reset();
    final file = await _cameraController.stopVideoRecording();
    setState(() {
      _isRecording = false;
    });

    if (!mounted) return;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoPreviewScreen(
                  video: file,
                  isPicked: false,
                )));
  }

  void _onPanStart(DragStartDetails details) {
    if (!_isRecording) return;
    _cameraController.setZoomLevel(_initZoomLevel);
  }

  Future<void> _onPanUpdate(DragUpdateDetails details) async {
    if (!_isRecording) return;
    double zoomChange = details.localPosition.dy * -0.01;
    _currentZoomLevel = (_initZoomLevel + zoomChange).clamp(1.0, _maxZoomLevel);
    await _cameraController.setZoomLevel(_currentZoomLevel);
    setState(() {});
  }

  @override
  void dispose() {
    _buttonanimationController.dispose();
    _timerAnimationController.dispose();
    if (!_noCamera) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  Future<void> _onPickVideoPress() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if (video == null) return;
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_noCamera) return;
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      disposeCamera();
    } else if (state == AppLifecycleState.resumed) {
      if (!_isCameraInitialized) {
        initCamera();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: !_hasPermission
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !_deniedPermission
                        ? const Column(children: [
                            Text(
                              "",
                              style: TextStyle(
                                fontSize: Sizes.size16,
                              ),
                            ),
                            Gaps.v20,
                            CircularProgressIndicator.adaptive(),
                          ])
                        : const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Can't acess to your camera.",
                                style: TextStyle(fontSize: Sizes.size20),
                              ),
                            ],
                          )
                  ],
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    if (!_noCamera && _cameraController.value.isInitialized)
                      SizedBox(
                          width: size.width,
                          height: size.height,
                          child: CameraPreview(_cameraController)),
                    const Positioned(
                        top: 40,
                        left: 20,
                        child: CloseButton(
                          color: Colors.white,
                        )),
                    if (!_noCamera)
                      Positioned(
                        top: 40,
                        right: 20,
                        child: !_isSelfieMode
                            ? Column(
                                children: [
                                  IconButton(
                                    color: Colors.white,
                                    onPressed: _toggleSelphieMode,
                                    icon: const Icon(
                                      Icons.cameraswitch_sharp,
                                    ),
                                  ),
                                  Gaps.v10,
                                  FlashButton(
                                      currentflashMode: _flashMode,
                                      setFlashMode: _setFlashMode,
                                      buttonflashMode: FlashMode.off,
                                      buttonicon: Icons.flash_off_rounded),
                                  Gaps.v10,
                                  FlashButton(
                                      currentflashMode: _flashMode,
                                      setFlashMode: _setFlashMode,
                                      buttonflashMode: FlashMode.always,
                                      buttonicon: Icons.flash_on_rounded),
                                  Gaps.v10,
                                  FlashButton(
                                      currentflashMode: _flashMode,
                                      setFlashMode: _setFlashMode,
                                      buttonflashMode: FlashMode.auto,
                                      buttonicon: Icons.flash_auto_rounded),
                                  Gaps.v10,
                                  FlashButton(
                                      currentflashMode: _flashMode,
                                      setFlashMode: _setFlashMode,
                                      buttonflashMode: FlashMode.torch,
                                      buttonicon: Icons.flashlight_on_rounded),
                                ],
                              )
                            : Column(
                                children: [
                                  IconButton(
                                    color: Colors.white,
                                    onPressed: _toggleSelphieMode,
                                    icon: const Icon(
                                      Icons.cameraswitch_sharp,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    Positioned(
                        width: MediaQuery.of(context).size.width,
                        bottom: Sizes.size40,
                        child: Row(
                          children: [
                            const Spacer(),
                            GestureDetector(
                              onPanStart: (DragStartDetails details) =>
                                  _onPanStart(details),
                              onPanUpdate: (DragUpdateDetails details) =>
                                  _onPanUpdate(details),
                              onTapDown: _startRecording,
                              onTapUp: (details) => _stopRecording(),
                              child: ScaleTransition(
                                scale: _buttonAnimation,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: Sizes.size80 + Sizes.size14,
                                      height: Sizes.size80 + Sizes.size14,
                                      child: CircularProgressIndicator(
                                        color: Colors.red.shade400,
                                        strokeWidth: Sizes.size6,
                                        value: _timerAnimationController.value,
                                      ),
                                    ),
                                    Container(
                                      width: Sizes.size80,
                                      height: Sizes.size80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: IconButton(
                                    onPressed: _onPickVideoPress,
                                    icon: const FaIcon(
                                      FontAwesomeIcons.image,
                                      color: Colors.white,
                                    )),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
        ));
  }
}
