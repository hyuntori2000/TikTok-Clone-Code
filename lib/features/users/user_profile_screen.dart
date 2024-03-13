import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_delegate.dart';
import 'package:tiktok_clone/features/users/widgets/user_info_status.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SettingsScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: const Text("Jihyun"),
                  actions: [
                    IconButton(
                        onPressed: _onGearPressed,
                        icon: const FaIcon(FontAwesomeIcons.gear))
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        foregroundColor: Theme.of(context).primaryColor,
                        foregroundImage: const NetworkImage(
                            "https://scontent-lax3-1.cdninstagram.com/v/t51.2885-19/306356666_651427379513488_369495744330421048_n.jpg?stp=dst-jpg_s320x320&_nc_ht=scontent-lax3-1.cdninstagram.com&_nc_cat=104&_nc_ohc=QeGnV4VXysUAX8jw1Z9&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfBdCHAlsRVzkSS0uUnnF8gBgqNkzVPEIlZHiRvZQf2azw&oe=65F51B78&_nc_sid=8b3546"),
                      ),
                      Gaps.v20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "@JihyunYuBen",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gaps.h5,
                          FaIcon(
                            FontAwesomeIcons.solidCircleCheck,
                            color: Colors.blue[600],
                            size: Sizes.size10,
                          )
                        ],
                      ),
                      Gaps.v20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const UserInfoWidget(number: "37", type: "Following"),
                          VerticalDivider(
                            color: Colors.grey.shade200,
                            width: 30,
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          const UserInfoWidget(
                              number: "10.3M", type: "Followers"),
                          VerticalDivider(
                            color: Colors.grey.shade200,
                            width: 30,
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          const UserInfoWidget(number: "149.3M", type: "Likes")
                        ],
                      ),
                      Gaps.v14,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: FractionallySizedBox(
                              widthFactor: 1,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Sizes.size12,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      Sizes.size4,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Follow",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Gaps.h5,
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 2,
                              ),
                            ),
                            child: const FaIcon(FontAwesomeIcons.youtube),
                          ),
                          Gaps.h5,
                          Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(Icons.more_horiz))
                        ],
                      ),
                      Gaps.v14,
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
                        child: Text(
                          "I'm Jihyun Yu!I'm Jihyun Yu!I'm Jihyun Yu!I'm Jihyun Yu!I'm Jihyun Yu!I'm Jihyun Yu!",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gaps.v14,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.link,
                            size: Sizes.size14,
                          ),
                          Gaps.h5,
                          Text(
                            "asdfasdfasdfasfdasfasdfaf",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      Gaps.v20,
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  delegate: PersistentTabBar(),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 40,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: Sizes.size2,
                      mainAxisSpacing: Sizes.size2,
                      childAspectRatio: 9 / 10),
                  itemBuilder: (context, index) => Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 9 / 10,
                        child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: "assets/images/placeholder.jpg",
                            image:
                                "https://plus.unsplash.com/premium_photo-1706625679706-68b966f820f2?q=80&w=1664&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                      ),
                      Positioned(
                        left: 5,
                        bottom: 5,
                        child: Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.play,
                              color: Colors.white,
                              size: Sizes.size14,
                            ),
                            Gaps.h5,
                            Text(
                              "$index",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Center(
                  child: Text(
                    "Page two",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
