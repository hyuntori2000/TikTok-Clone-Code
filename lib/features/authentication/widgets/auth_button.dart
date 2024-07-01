import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';

class AuthButton extends ConsumerWidget {
  final String text;
  final FaIcon icon;
  final String type;
  final Widget? navigateTo;
  const AuthButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.type,
      this.navigateTo});
  void onTapAuthButton(BuildContext context, WidgetRef ref) {
    if (type == "Github") {
      ref.read(socialAuthProvier.notifier).githubSignIn(context);
    } else if (navigateTo != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => navigateTo!));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => onTapAuthButton(context, ref),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Sizes.size7, horizontal: Sizes.size7),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size14,
              horizontal: Sizes.size14,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
                width: Sizes.size1,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(alignment: Alignment.centerLeft, child: icon),
                Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: Sizes.size16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
