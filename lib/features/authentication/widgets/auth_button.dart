import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final Widget type;
  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.type,
  });
  void onTapAuthButton(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => type));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapAuthButton(context),
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
