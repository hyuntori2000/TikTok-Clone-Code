import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/authentication/%08email_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/users/view_models/profile_view_model.dart';

class EmailScreenArgs {
  final String username;
  EmailScreenArgs(
      {required this.username}); //this class is the box that saving the data that i recieve this screen. and pass to the next screen.
}

class UsernameScreen extends ConsumerStatefulWidget {
  static String routeURL = "username";
  static String routeName = "username_screen";
  const UsernameScreen({super.key});

  @override
  ConsumerState<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends ConsumerState<UsernameScreen> {
  final TextEditingController _usernameController =
      TextEditingController(); //controlling textediting(listener).
  String _username = "";
  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
//when user put text in the input box Controller accept the data and place on the console immidiat
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void onNextTap() {
    if (_username.isEmpty) return;
    ref.read(profileViewModel.notifier).setInputNAme(_username);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmailScreen(username: _username)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "Create username",
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
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: "Username",
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
              child: FormButton(
                inactive: "Sign up",
                active: "Next",
                disabled: _username.isEmpty,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
