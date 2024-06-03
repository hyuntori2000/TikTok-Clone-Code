import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/%08videos/Views/video_recording_screen.dart';
import 'package:tiktok_clone/features/%08videos/Views/video_timeline_screen.dart';
import 'package:tiktok_clone/features/Inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';

import 'package:tiktok_clone/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  static String routename = "mainNavigation";

  final String tab;
  const MainNavigationScreen({super.key, required this.tab});

  @override
  State<MainNavigationScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "discover",
    "xxxx",
    "inbox",
    "profile",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  bool onPressing = false;
  void pressing(TapDownDetails) {
    setState(() {
      onPressing = true;
    });
  }

  void quit(TapUpDetails) {
    setState(() {
      onPressing = false;
    });
  }

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Offstage(
              offstage: _selectedIndex != 0,
              child: const VideoTimelineScreen()),
          Offstage(
              offstage: _selectedIndex != 1, child: const DiscoverScreen()),
          Offstage(offstage: _selectedIndex != 3, child: const InboxScreen()),
          Offstage(
              offstage: _selectedIndex != 4,
              child: const UserProfileScreen(
                username: "Yunseo",
                tab: "happy",
              )),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                label: "Home",
                isSelected: _selectedIndex == 0,
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(0),
              ),
              NavTab(
                selectedIcon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTap(1),
                icon: FontAwesomeIcons.compass,
                label: "Discover",
                isSelected: _selectedIndex == 1,
                selectedIndex: _selectedIndex,
              ),
              Gaps.h24,
              GestureDetector(
                onTap: _onPostVideoButtonTap,
                onTapDown: pressing,
                onTapUp: quit,
                child: PostVideoButton(
                  inverted: _selectedIndex != 0,
                  fingerOn: onPressing,
                ),
              ),
              Gaps.h24,
              NavTab(
                selectedIcon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTap(3),
                icon: FontAwesomeIcons.message,
                label: "Inbox",
                isSelected: _selectedIndex == 3,
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                selectedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(4),
                icon: FontAwesomeIcons.user,
                label: "Profile",
                isSelected: _selectedIndex == 4,
                selectedIndex: _selectedIndex,
              )
            ]),
      ),
    );
  }
}
