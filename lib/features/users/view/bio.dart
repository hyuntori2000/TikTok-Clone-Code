import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/authentication/%08email_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';
import 'package:tiktok_clone/features/users/view_models/profile_view_model.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class BioEditScreen extends ConsumerStatefulWidget {
  static String routeURL = "username";
  static String routeName = "username_screen";
  const BioEditScreen({super.key});

  @override
  ConsumerState<BioEditScreen> createState() => _BioEditScreenState();
}

class _BioEditScreenState extends ConsumerState<BioEditScreen> {
  final TextEditingController _bioController =
      TextEditingController(); //controlling textediting(listener).
  String _bio = ""; // 여기는 유저네임 가져온것 처럼 current bio를 가져와서 채워 넣는다.
  @override
  void initState() {
    super.initState();
    _bioController.addListener(() {
      setState(() {
        _bio = _bioController.text;
      });
//when user put text in the input box Controller accept the data and place on the console immidiat
    });
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  void onNextTap() {
    ref.read(usersProvider.notifier).onBioEdit(_bio);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile Editing",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "Edit your Profile",
              style: TextStyle(
                  fontSize: Sizes.size24, fontWeight: FontWeight.w700),
            ),
            Gaps.v8,
            const Text(
              "You can always change this later.",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black38,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(
                hintText: "biography",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v16,
            GestureDetector(
              onTap: onNextTap,
              child: const FormButton(
                inactive: "",
                active: "Done",
                disabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
