import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashButton extends StatelessWidget {
  final FlashMode currentflashMode;
  final FlashMode buttonflashMode;
  final IconData buttonicon;
  final Function(FlashMode) setFlashMode;
  const FlashButton(
      {super.key,
      required this.currentflashMode,
      required this.setFlashMode,
      required this.buttonflashMode,
      required this.buttonicon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: currentflashMode == buttonflashMode ? Colors.yellow : Colors.white,
      onPressed: () => setFlashMode(buttonflashMode),
      icon: Icon(buttonicon),
    );
  }
}
