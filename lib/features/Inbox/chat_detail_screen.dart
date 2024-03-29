import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chatTextInputController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _chatTextInputController.addListener(() {});
  }

  @override
  void dispose() {
    _chatTextInputController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    _chatTextInputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size6,
          leading: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              const CircleAvatar(
                child: Text("JH"),
              ),
              Positioned(
                  right: 0.5,
                  bottom: 0.5,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2.5),
                        borderRadius: BorderRadius.circular(90),
                        color: Colors.green),
                  ))
            ],
          ),
          title: const Text(
            'Jihyun',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text(
            "Active now",
            style: TextStyle(
              color: Colors.black45,
            ),
          ),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20,
                horizontal: Sizes.size14,
              ),
              itemBuilder: (context, index) {
                final isMine = index % 2 ==
                    0; // this is just a sample. in real product isMine will be defined by the api.

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Sizes.size16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20),
                            topRight: const Radius.circular(20),
                            bottomLeft: Radius.circular(isMine ? 20 : 5),
                            bottomRight: Radius.circular(isMine ? 5 : 20)),
                        color: isMine ? Colors.blue : Colors.grey,
                      ),
                      child: const Text(
                        "This is a message",
                        style: TextStyle(
                            color: Colors.white, fontSize: Sizes.size16),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: 10),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
                color: Colors.grey.shade100,
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: _chatTextInputController,
                      expands: true,
                      minLines: null,
                      maxLines: null,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        hintText: "Type here..",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: Sizes
                                .size10), //before i clearied the content padding the default padding at the bottom cut the text in the Textfield.
                        suffixIcon: const Padding(
                          padding: EdgeInsets.all(Sizes.size10),
                          child: FaIcon(FontAwesomeIcons.faceSmile),
                        ),

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              Sizes.size12,
                            ),
                            borderSide: BorderSide.none),
                      ),
                    )),
                    Gaps.h20,
                    GestureDetector(
                        onTap: _onSubmit,
                        child: const FaIcon(FontAwesomeIcons.paperPlane))
                  ],
                )),
          )
        ],
      ),
    );
  }
}
