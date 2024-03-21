import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/utils.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showPage = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      setState(() {
        _direction = Direction.right;
      });
    } else {
      _direction = Direction.left;
    }
  }

  void _onPanEnd(DragEndDetails detail) {
    if (_direction == Direction.left) {
      setState(() {
        _showPage = Page.second;
      });
    } else {
      setState(() {
        _showPage = Page.first;
      });
    }
  }

  void _onButtonTap() {
    context.push(MainNavigationScreen.routename);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
          body: SafeArea(
            child: AnimatedCrossFade(
              crossFadeState: _showPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
              firstChild: const Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gaps.v52,
                      Text(
                        "Watch cool videos!",
                        style: TextStyle(
                          fontSize: Sizes.size36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v12,
                      Text(
                        "Videos are personalized for you based on what you watch, like and share.",
                        style: TextStyle(
                          fontSize: Sizes.size20,
                          color: Colors.black38,
                        ),
                      )
                    ],
                  ),
                ),
              ]),
              secondChild: const Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gaps.v52,
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: Text(
                          "Follow the rules",
                          style: TextStyle(
                            fontSize: Sizes.size36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Gaps.v12,
                      Text(
                        "Take care of on another. plz",
                        style: TextStyle(
                          fontSize: Sizes.size20,
                          color: Colors.black38,
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: isDarkMode(context) ? Colors.black : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size2, horizontal: Sizes.size20),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _showPage == Page.first ? 0 : 1,
                child: CupertinoButton(
                    onPressed: _onButtonTap,
                    color: Theme.of(context).primaryColor,
                    child: const Text(
                      "Enter the app",
                    )),
              ),
            ),
          )),
    );
  }
}
