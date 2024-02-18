import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/%08videos/video_timeline_screen.dart';
import 'package:tiktok_clone/features/Inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';

import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/post_video_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;

  final screens = [
    const Center(
      child: Text('home'),
    ),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('home'),
    ),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Hi'),
    )
  ];
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
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Recording')),
      ),
      fullscreenDialog: true,
    ));
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
          Offstage(offstage: _selectedIndex != 4, child: Container()),
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
