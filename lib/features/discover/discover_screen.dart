import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = ["Tab", "Users", "Videos", "Sounds", "LIVE", "Shopping", "Brands"];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController =
      TextEditingController(text: "What are you looking for?");

  late TabController _tabController;

  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(_onTabSelection);
    _textEditingController.addListener(_onTyping);
  }

  void _onTyping() {
    setState(() {
      _isTyping = true;
    });
  }

  void _onTabSelection() {
    if (_tabController.indexIsChanging) {
      Future.delayed(Duration.zero, () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
          setState(() {
            _isTyping = false;
          });
        }
      });
    }
  }

  void _deleteText() {
    _textEditingController.text = "";
  }

  @override
  void dispose() {
    _tabController;
    _textEditingController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: SizedBox(
            height: 44,
            child: TextField(
              onTap: _onTyping,
              controller: _textEditingController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(
                      Sizes.size12,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: _deleteText,
                      child: _isTyping
                          ? FaIcon(
                              FontAwesomeIcons.solidCircleXmark,
                              color: Colors.grey.shade500,
                            )
                          : null,
                    ),
                  )),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            unselectedLabelColor: Colors.grey.shade500,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(Sizes.size6),
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: Sizes.size10,
                    mainAxisSpacing: Sizes.size10,
                    childAspectRatio: 9 / 20),
                itemBuilder: (context, index) => Column(
                      children: [
                        Container(
                          clipBehavior: Clip
                              .hardEdge, // need this cuz the image is overflowing the Container.
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Sizes.size4)),
                          child: AspectRatio(
                            aspectRatio: 9 / 16,
                            child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                placeholder: "assets/images/placeholder.jpg",
                                image:
                                    "https://plus.unsplash.com/premium_photo-1706625679706-68b966f820f2?q=80&w=1664&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                          ),
                        ),
                        Gaps.v10,
                        const Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          "This is a very long caption for my tiktok that i'm upload just now",
                          style: TextStyle(
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gaps.v5,
                        DefaultTextStyle(
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(
                                    "https://avatars.githubusercontent.com/u/131842228?v=4&size=40"),
                              ),
                              Gaps.h4,
                              const Expanded(
                                  child: Text(
                                'Jihyun_yu_hello_yunseo hahahahah',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )),
                              Gaps.h4,
                              FaIcon(
                                FontAwesomeIcons.heart,
                                size: Sizes.size16,
                                color: Colors.grey.shade500,
                              ),
                              Gaps.h2,
                              const Text(
                                "2.5M",
                              )
                            ],
                          ),
                        )
                      ],
                    )),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
//as