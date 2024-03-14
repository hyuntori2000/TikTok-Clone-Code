import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/log_in_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        //context will send the Orientation of the device.
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(
                children: [
                  Gaps.v80,
                  const Text(
                    "Sign up for TikTok",
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  const Text(
                    "Create a profile, follow other accounts, make your own videos, and more.",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: Colors.black45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    const AuthButton(
                        type: UsernameScreen(),
                        icon: FaIcon(FontAwesomeIcons.solidUser),
                        text: "Use phone or email"),
                    const AuthButton(
                        type: UsernameScreen(),
                        icon: FaIcon(FontAwesomeIcons.apple),
                        text: "Continue with Facebook"),
                  ],
                  if (orientation == Orientation.landscape)
                    const Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                              type: UsernameScreen(),
                              icon: FaIcon(FontAwesomeIcons.solidUser),
                              text: "Use phone or email"),
                        ),
                        Expanded(
                          child: AuthButton(
                              type: UsernameScreen(),
                              icon: FaIcon(FontAwesomeIcons.apple),
                              text: "Continue with Facebook"),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              color: Colors.grey.shade50,
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    Gaps.h5,
                    GestureDetector(
                      onTap: () => _onLoginTap(context),
                      child: Text(
                        "Log in",
                        style: TextStyle(
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
