import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/Inbox/activity_screen.dart';
import 'package:tiktok_clone/features/Inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/features/Inbox/direct_message.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});
  void _onDmPress(BuildContext context) {
    context.pushNamed(DirectMessageScreen.routeName);
  }

  void _navigateToActivity(BuildContext context) {
    context.pushNamed(ActivityScreen.routeName);
  } // Beacuse it's stateless widget I',m supposed to pass context to tghe fuction manually.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("inbox"),
        actions: [
          IconButton(
            onPressed: () => _onDmPress(context),
            icon: const FaIcon(
              FontAwesomeIcons.paperPlane,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () =>
                _navigateToActivity(context), // 넘겨주어야 할것이 필요할때는 () =>를 사용한다.
            title: const Text(
              "Activity",
              style: TextStyle(
                fontSize: Sizes.size18,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
            ),
          ),
          Container(
            height: Sizes.size1,
            color: Colors.grey.shade100,
          ),
          ListTile(
            leading: Container(
                width: Sizes.size52,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                ),
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.users,
                    color: Colors.white,
                  ),
                )),
            title: const Text(
              "New followers",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text(
              "Message from followers will appear here",
              style: TextStyle(fontSize: Sizes.size14),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
            ),
          )
        ],
      ),
    );
  }
}
