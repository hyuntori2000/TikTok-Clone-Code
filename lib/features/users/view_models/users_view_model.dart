import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';
import 'package:tiktok_clone/features/users/view_models/profile_view_model.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _repository;
  @override
  FutureOr<UserProfileModel> build() {
    _repository = ref.read(userRepo);
    return UserProfileModel.empty();
  }

  Future<void> createProfile(
    UserCredential credential,
  ) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = const AsyncValue.loading();
    final sideinfo = ref.read(profileViewModel);
    final profile = UserProfileModel(
        bio: "...",
        link: "...",
        uid: credential.user!.uid,
        name: credential.user!.displayName ?? "noname",
        email: credential.user!.email ?? "where@you.at",
        username: sideinfo.value?.inputName ?? "Notnamed",
        birthday: sideinfo.value?.inputBirthday ?? "...");
    await _repository.createPRofile(profile);
    state = AsyncValue.data(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () =>
      UsersViewModel(), //이번 프로바이더가 void를 쓰지 않는 이유는 작동 뿐만아니라 저장까지 하기위해서다 유저가 로그인을 할때 이메일이나 유저아이디를 입력한 값이 그대로 데이터 베이스로 실시간을 이동해서 저장해야하기 때문.
);
