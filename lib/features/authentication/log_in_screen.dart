import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/features/utils.dart';

class LoginScreen extends StatelessWidget {
  static String routeURL = "/loginScreen";
  static String routeName = "login_screen";
  const LoginScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              const Text(
                "Log in for TikTok",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              const Opacity(
                opacity: 0.6,
                child: Text(
                  "Manage your account, check notifications, comment on videos, and more.",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v40,
              AuthButton(
                  type: LoginFormScreen.routeName,
                  icon: const FaIcon(FontAwesomeIcons.solidUser),
                  text: "Use phone or email"),
              AuthButton(
                  type: LoginFormScreen.routeName,
                  icon: const FaIcon(FontAwesomeIcons.apple),
                  text: "Continue with Facebook"),
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
                const Text("Don't have an account?"),
                Gaps.h5,
                GestureDetector(
                  onTap: () => _onSignUpTap(context),
                  child: Text(
                    "Sign up",
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
  }
}
