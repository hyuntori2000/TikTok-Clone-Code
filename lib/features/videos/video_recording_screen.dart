import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false;
  bool _deniedPermission = false;
  bool _isSelfieMode = false;
  late CameraController _cameraController;
  late FlashMode _flashMode;

  Future<void> initCamera() async {
    final cameras =
        await availableCameras(); // this will give lists of all camera.
    if (cameras.isEmpty) {
      return;
    } //만약에 카메라를 인식하지 못했을경우 실행을 중단한다.
    _cameraController = CameraController(
        cameras[_isSelfieMode ? 1 : 0], ResolutionPreset.ultraHigh);

    await _cameraController.initialize();
    _flashMode = _cameraController.value.flashMode;
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
    initPermissions();
    super.initState();
  }

  Future<void> _toggleSelphieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera(); // after changeing the cameramode we should initialize the camera again.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: !_hasPermission || !_cameraController.value.isInitialized
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
                  children: [
                    CameraPreview(_cameraController),
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
                                IconButton(
                                  color: _flashMode == FlashMode.off
                                      ? Colors.yellow
                                      : Colors.white,
                                  onPressed: () => _setFlashMode(FlashMode.off),
                                  icon: const Icon(
                                    Icons.flash_off_rounded,
                                  ),
                                ),
                                Gaps.v10,
                                IconButton(
                                  color: _flashMode == FlashMode.always
                                      ? Colors.yellow
                                      : Colors.white,
                                  onPressed: () =>
                                      _setFlashMode(FlashMode.always),
                                  icon: const Icon(
                                    Icons.flash_on_rounded,
                                  ),
                                ),
                                Gaps.v10,
                                IconButton(
                                  color: _flashMode == FlashMode.auto
                                      ? Colors.yellow
                                      : Colors.white,
                                  onPressed: () =>
                                      _setFlashMode(FlashMode.auto),
                                  icon: const Icon(
                                    Icons.flash_auto_rounded,
                                  ),
                                ),
                                Gaps.v10,
                                IconButton(
                                  color: _flashMode == FlashMode.torch
                                      ? Colors.yellow
                                      : Colors.white,
                                  onPressed: () =>
                                      _setFlashMode(FlashMode.torch),
                                  icon: const Icon(
                                    Icons.flashlight_on_rounded,
                                  ),
                                ),
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
                    )
                  ],
                ),
        ));
  }
}
