import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repository/authentication_repo.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';
import 'package:tiktok_clone/features/users/view_models/profile_view_model.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authrepository;
  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(
        userRepo); // withthis i can call the user profile in firebase database. and upload the userinfo.
    _authrepository = ref.read(
        authRepo); // this is just for the authenticate the user is registered on the sysyem
    if (_authrepository.isLoggedIn) {
      final profile =
          await _userRepository.findProfile(_authrepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
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
        birthday: sideinfo.value?.inputBirthday ?? "...",
        hasAvatar: false);
    await _userRepository.createPRofile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    await _userRepository.updateUser(state.value!.uid, {
      "hasAvatar": true
    }); // update data on the screen. beacause the usersviewmodel is the one who painting the screen.
  }

  Future<void> onBioEdit() async {}
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () =>
      UsersViewModel(), //이번 프로바이더가 void를 쓰지 않는 이유는 작동 뿐만아니라 저장까지 하기위해서다 유저가 로그인을 할때 이메일이나 유저아이디를 입력한 값이 그대로 데이터 베이스로 실시간을 이동해서 저장해야하기 때문.
);
