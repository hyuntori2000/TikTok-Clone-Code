// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/video_config/video_config.dart';
import 'package:tiktok_clone/features/%08videos/view_models/playback_config_viewmodel.dart';
import 'package:tiktok_clone/features/authentication/repository/authentication_repo.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("setting"),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).muted,
            onChanged: (value) =>
                {ref.read(playbackConfigProvider.notifier).setMuted(value)},
            title: const Text("Mute video"),
            subtitle: const Text("Video will be muted by default"),
          ),
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).autoplay,
            onChanged: (value) =>
                {ref.read(playbackConfigProvider.notifier).setAutoplay(value)},
            title: const Text("Auto Play"),
            subtitle: const Text("Video will autoplay by default"),
          ),
          SwitchListTile(
            inactiveThumbColor: Colors.black,
            inactiveTrackColor: Colors.grey.shade200,
            activeColor: Colors.black,
            value: false,
            onChanged: (value) {},
            title: const Text("Marketing emails"),
          ),
          CheckboxListTile(
              activeColor: Colors.black,
              title: const Text("Enable notifications"),
              value: false,
              onChanged: (value) {}),
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
                        onPressed: () {
                          ref.read(authRepo).signOut();
                          context.go("/");
                        })
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
