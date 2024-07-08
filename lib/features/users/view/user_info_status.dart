import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserInfoWidget extends StatelessWidget {
  final String number;
  final String type;
  const UserInfoWidget({
    super.key,
    required this.number,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: Sizes.size18),
        ),
        Gaps.v3,
        Text(
          type,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black26,
              fontSize: Sizes.size14),
        ),
      ],
    );
  }
}
