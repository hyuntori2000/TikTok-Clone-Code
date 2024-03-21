import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/log_in_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/features/utils.dart';

class SignUpScreen extends StatelessWidget {
  static String routeURL = "/";
  static String routeName = "signUp";
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    context.go(LoginScreen.routeURL);
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
                  Text(
                    "Create a profile, follow other accounts, make your own videos, and more.",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: isDarkMode(context)
                          ? Colors.grey.shade300
                          : Colors.black45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                        type: UsernameScreen.routeName,
                        icon: const FaIcon(FontAwesomeIcons.solidUser),
                        text: "Use phone or email"),
                    AuthButton(
                        type: UsernameScreen.routeName,
                        icon: const FaIcon(FontAwesomeIcons.apple),
                        text: "Continue with Facebook"),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                              type: UsernameScreen.routeName,
                              icon: const FaIcon(FontAwesomeIcons.solidUser),
                              text: "Use phone or email"),
                        ),
                        Expanded(
                          child: AuthButton(
                              type: UsernameScreen.routeName,
                              icon: const FaIcon(FontAwesomeIcons.apple),
                              text: "Continue with Facebook"),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              color: isDarkMode(context) ? null : Colors.grey.shade50,
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
