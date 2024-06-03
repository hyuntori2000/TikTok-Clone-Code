// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/video_config/video_config.dart';
import 'package:tiktok_clone/features/%08videos/view_models/playback_config_viewmodel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notification = false;
  bool _agreement = false;

  void _onNotificationChanged(bool? newValue) {
    //bool? newValue의 뜻은 null값을 가질 수 있는 bool 타입의 variable 인 newValue를 뜻한다.
    if (newValue == null) return;
    setState(() {
      _notification = newValue;
    });
  }

  void _onAgreementChange(bool? newValue) {
    //bool? newValue의 뜻은 null값을 가질 수 있는 bool 타입의 variable 인 newValue를 뜻한다.
    if (newValue == null) return;
    setState(() {
      _agreement = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("setting"),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: context.watch<PlaybackConfigViewModel>().muted,
            onChanged: (value) =>
                context.read<PlaybackConfigViewModel>().setMuted(value),
            title: const Text("Mute video"),
            subtitle: const Text("Video will be muted by default"),
          ),
          SwitchListTile.adaptive(
            value: context.watch<PlaybackConfigViewModel>().autoplay,
            onChanged: (value) =>
                context.read<PlaybackConfigViewModel>().setAutoplay(value),
            title: const Text("Auto Play"),
            subtitle: const Text("Video will autoplay by default"),
          ),
          SwitchListTile(
            inactiveThumbColor: Colors.black,
            inactiveTrackColor: Colors.grey.shade200,
            activeColor: Colors.black,
            value: _agreement,
            onChanged: _onAgreementChange,
            title: const Text("Marketing emails"),
          ),
          CheckboxListTile(
              activeColor: Colors.black,
              title: const Text("Enable notifications"),
              value: _notification,
              onChanged: _onNotificationChanged),
          ListTile(
            onTap: () async {
              final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1980),
                  lastDate: DateTime.now(),
                  initialDate: DateTime.now());
              print(date);
              final time = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              print(time);
              final booking = await showDateRangePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(2025),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                        appBarTheme: const AppBarTheme(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    )),
                    child: child!,
                  );
                },
              );

              print(booking);
            },
            title: const Text(
              "What is your birthday?",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          ListTile(
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("Plz don't go"),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text("No"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      child: const Text("Yes"),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              );
            },
            textColor: Colors.red,
            title: const Text(
              "Log out (iOS)",
            ),
          ),
          ListTile(
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  title: const Text("Are you sure?"),
                  actions: [
                    CupertinoActionSheetAction(
                        onPressed: () {}, child: const Text("Log Out"))
                  ],
                ),
              );
            },
            textColor: Colors.red,
            title: const Text(
              "Log out (iOS / bottom )",
            ),
          ),
          const AboutListTile(),
        ],
      ),
    );
  }
}
