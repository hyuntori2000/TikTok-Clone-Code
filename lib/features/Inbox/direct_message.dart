import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/Inbox/chat_detail_screen.dart';

class DirectMessageScreen extends StatefulWidget {
  const DirectMessageScreen({super.key});

  @override
  State<DirectMessageScreen> createState() => _DirectMessageScreenState();
}

class _DirectMessageScreenState extends State<DirectMessageScreen> {
  final GlobalKey<AnimatedListState> _key =
      GlobalKey<AnimatedListState>(); //annimatedList has it's own list.
  final List<int> _items =
      []; //need the empty array cuz I need to keep the array when i add the item at the end of the list.
  final Duration _duration = const Duration(milliseconds: 300);

  void _onPlusIcon() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(_items.length,
          duration:
              _duration); // put 0 because i want the item added at the beginnig of the list.
      _items.add(_items.length);
    }
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
          index,
          (context, animation) => SizeTransition(
              sizeFactor: animation,
              child: Container(
                color: Colors.red,
                child: _makeItem(index),
              )),
          duration: _duration);
      _items.removeAt(index);
    }
  }

  Widget _makeItem(int index) {
    return ListTile(
      onLongPress: () => _deleteItem(index),
      onTap: _onChatTap,
      leading: const CircleAvatar(
        radius: 30,
        foregroundImage: NetworkImage(
            "https://www.stussy.com/cdn/shop/products/1905000_NAVY_2.jpg?v=1707148338&width=480"),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "$index",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("12:20 PM",
              style: TextStyle(
                fontSize: Sizes.size12,
                color: Colors.grey.shade400,
              )),
        ],
      ),
      subtitle: Text(
        "message",
        style: TextStyle(
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  void _onChatTap() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ChatScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Direct Message"),
        elevation: 1,
        actions: [
          IconButton(
              onPressed: _onPlusIcon, icon: const FaIcon(FontAwesomeIcons.plus))
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            key:
                UniqueKey(), // so flutter will not get confused between key for animatedlist and listtile.
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: _makeItem(
                index,
              ),
            ),
          );
        },
      ),
    );
  }
}
