import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/view/avatar.dart';
import 'package:tiktok_clone/features/users/view/bio.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/view/persistent_delegate.dart';
import 'package:tiktok_clone/features/users/view/user_info_status.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;
  const UserProfileScreen(
      {super.key, required this.username, required this.tab});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SettingsScreen(),
    ));
  }

  void _onEditBio() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const BioEditScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ref.watch(usersProvider).when(
        error: ((error, stackTrace) => Center(
              child: Text(
                error.toString(),
              ),
            )),
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
        data: (data) => Scaffold(
              body: SafeArea(
                child: DefaultTabController(
                  initialIndex: widget.tab == "likes" ? 1 : 0,
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          title: Text(data.username),
                          actions: [
                            IconButton(
                                onPressed: _onGearPressed,
                                icon: const FaIcon(FontAwesomeIcons.gear))
                          ],
                        ),
                        SliverToBoxAdapter(
                          child: width < BreakPoints.sm
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Avatar(
                                      name: data.username,
                                      uid: data.uid,
                                      hasAvatar: data.hasAvatar,
                                    ),
                                    Gaps.v20,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "@${data.username}",
                                          style: const TextStyle(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const UserInfoWidget(
                                            number: "37", type: "Following"),
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
                                        const UserInfoWidget(
                                            number: "149.3M", type: "Likes")
                                      ],
                                    ),
                                    Gaps.v14,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          child: FractionallySizedBox(
                                            widthFactor: 1,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: Sizes.size12,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    const BorderRadius.all(
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
                                          child: const FaIcon(
                                              FontAwesomeIcons.youtube),
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: Sizes.size32),
                                      child: GestureDetector(
                                        onTap: _onEditBio,
                                        child: Text(
                                          data.bio,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Gaps.v14,
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 45,
                                        foregroundColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Gaps.h10,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "@${widget.username}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Gaps.h5,
                                            FaIcon(
                                              FontAwesomeIcons.solidCircleCheck,
                                              color: Colors.blue[600],
                                              size: Sizes.size10,
                                            ),
                                            Gaps.h32,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    "I'm ${widget.username}!I'm ${widget.username}!",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons.link,
                                                      size: Sizes.size14,
                                                    ),
                                                    Gaps.h5,
                                                    Text(
                                                      "asdfasdfasdfasfdasfasdfaf",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Gaps.v20,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const UserInfoWidget(
                                                number: "37",
                                                type: "Following"),
                                            VerticalDivider(
                                              color: Colors.grey.shade200,
                                              width: 30,
                                              thickness: 1,
                                              indent: 10,
                                              endIndent: 10,
                                            ),
                                            const UserInfoWidget(
                                                number: "10.3M",
                                                type: "Followers"),
                                            VerticalDivider(
                                              color: Colors.grey.shade200,
                                              width: 30,
                                              thickness: 1,
                                              indent: 10,
                                              endIndent: 10,
                                            ),
                                            const UserInfoWidget(
                                                number: "149.3M",
                                                type: "Likes"),
                                            Gaps.h5,
                                          ],
                                        ),
                                        Gaps.v20,
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 180,
                                              child: FractionallySizedBox(
                                                widthFactor: 1,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: Sizes.size12,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        const BorderRadius.all(
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
                                            Gaps.h20,
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey.shade200,
                                                  width: 2,
                                                ),
                                              ),
                                              child: const FaIcon(
                                                  FontAwesomeIcons.youtube),
                                            ),
                                            Gaps.h5,
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey.shade200,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: const Icon(
                                                    Icons.more_horiz)),
                                          ],
                                        ),
                                        Gaps.v28,
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      width > BreakPoints.lg ? 6 : 3,
                                  crossAxisSpacing: Sizes.size2,
                                  mainAxisSpacing: Sizes.size2,
                                  childAspectRatio: 9 / 10),
                          itemBuilder: (context, index) => Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: 9 / 10,
                                child: FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    placeholder:
                                        "assets/images/placeholder.jpg",
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
                                      style:
                                          const TextStyle(color: Colors.white),
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
            ));
  }
}
