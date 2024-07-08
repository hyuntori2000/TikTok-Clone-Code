import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repository/authentication_repo.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(userRepo); // initiate the repository of the user.
  }

  Future<void> connectUidAndAvatar(
    File file,
  ) async {
    state = const AsyncValue.loading();
    final fileName = ref
        .read(authRepo)
        .user!
        .uid; // read the current user connected to avatar.
    state = await AsyncValue.guard(() async {
      await _repository.uploadAvatar(
          file, fileName); // put the avater image on storage
      await ref
          .read(usersProvider.notifier)
          .onAvatarUpload(); //let the data model know the avatar uploaded.(change hasAvatar)
    });
  }
}

// The role of viewmodel is connection between database and view it is the gated bridge between them. useing AsyncNotifier it catches error or loading and send and recieve data between them.
final avatarProvider =
    AsyncNotifierProvider<AvatarViewModel, void>(() => AvatarViewModel());
