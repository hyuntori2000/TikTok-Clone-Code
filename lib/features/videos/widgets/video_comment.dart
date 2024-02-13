import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VIdeoComments extends StatefulWidget {
  const VIdeoComments({super.key});

  @override
  State<VIdeoComments> createState() => _VIdeoCommentsState();
}

class _VIdeoCommentsState extends State<VIdeoComments> {
  final ScrollController _scrollController = ScrollController();
  bool _isWriting = false;

  void _onClosedPressed() {
    Navigator.of(context).pop();
  }

  void _stopComment() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      clipBehavior: Clip.hardEdge,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(Sizes.size14)),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          actions: [
            IconButton(
              onPressed: _onClosedPressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            )
          ],
          automaticallyImplyLeading: false,
          title: const Text(
            "Number of comments",
          ),
        ),
        body: GestureDetector(
          onTap: _stopComment,
          child: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                      top: Sizes.size10,
                      bottom: Sizes.size96 + Sizes.size40,
                      left: Sizes.size16,
                      right: Sizes.size16),
                  separatorBuilder: (context, index) => Gaps.v20,
                  itemCount: 10,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        child: (Text(
                          "JY",
                        )),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "user",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Gaps.v2,
                            const Text(
                              "info",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gaps.h10,
                      Column(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.heart,
                            color: Colors.grey.shade400,
                            size: Sizes.size20,
                          ),
                          Gaps.v2,
                          Text(
                            "20",
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: BottomAppBar(
                  padding: const EdgeInsets.only(
                    left: Sizes.size16,
                    right: Sizes.size16,
                    bottom: Sizes.size10,
                    top: Sizes.size10,
                  ),
                  color: Colors.white,
                  child: Row(children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey.shade500,
                      child: const Text("JY"),
                    ),
                    Gaps.h10,
                    Expanded(
                      child: SizedBox(
                        height: Sizes.size44,
                        child: TextField(
                          onTap: _onStartWriting,
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          textInputAction: TextInputAction
                              .newline, //to use the done button as return button.
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.size12,
                              ),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size12,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(
                                right: Sizes.size14,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.at,
                                    color: Colors.grey.shade900,
                                  ),
                                  Gaps.h14,
                                  FaIcon(
                                    FontAwesomeIcons.gift,
                                    color: Colors.grey.shade900,
                                  ),
                                  Gaps.h14,
                                  if (_isWriting)
                                    GestureDetector(
                                      onTap: _stopComment,
                                      child: FaIcon(FontAwesomeIcons.arrowUp,
                                          color:
                                              Theme.of(context).primaryColor),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
