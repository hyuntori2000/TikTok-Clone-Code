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
  late final CameraController _cameraController;
  Future<void> initCamera() async {
    final cameras =
        await availableCameras(); // this will give lists of all camera.
    if (cameras.isEmpty) {
      return;
    } //만약에 카메라를 인식하지 못했을경우 실행을 중단한다.
    _cameraController =
        CameraController(cameras[0], ResolutionPreset.ultraHigh);

    await _cameraController.initialize();
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

  @override
  void initState() {
    initPermissions();
    super.initState();
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
                              "We need permissions...",
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
                  ],
                ),
        ));
  }
}
