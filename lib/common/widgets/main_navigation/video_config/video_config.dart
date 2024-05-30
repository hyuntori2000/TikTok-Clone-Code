import 'package:flutter/cupertino.dart';

class VideoConfig extends ChangeNotifier {
  bool autoMute = true;

  void toggleAutoMute() {
    autoMute = !autoMute;
    notifyListeners(); //이렇게만 하면 이 위젯안에 있는 발류가 바뀐것 즉 스테이트풀 위젯처럼 작동하여 모든 해당 VideoConfig가 있는 위젯트리에 발류가 바뀜을 알려준다.
  }
}

final videoConfig = VideoConfig();
