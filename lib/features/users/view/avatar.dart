import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/features/users/view_models/avatar_view_mode.dart';

class Avatar extends ConsumerWidget {
  final String name;
  final bool hasAvatar;
  final String uid;
  const Avatar({
    super.key,
    required this.name,
    required this.hasAvatar,
    required this.uid,
  });

  Future<void> _onAvartarTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
        maxHeight: 150,
        maxWidth: 150);
    if (xfile != null) {
      final file = File(xfile.path);
      ref.read(avatarProvider.notifier).connectUidAndAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    return GestureDetector(
      onTap: isLoading
          ? null
          : () => _onAvartarTap(ref), //if it is loading nothing will be happend
      child: isLoading
          ? Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator.adaptive(),
            )
          : CircleAvatar(
              radius: 50,
              foregroundImage: hasAvatar
                  ? NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/practice522-8bd02.appspot.com/o/avatars%2F$uid?alt=media&token=7580c179-7e8b-417c-b9e6-7ec595b7e172&haha=${DateTime.now().toString()}"
                      "")
                  : null,
              child: Text(name),
            ),
    );
  }
}
