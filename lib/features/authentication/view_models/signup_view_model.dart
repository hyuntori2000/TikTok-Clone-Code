import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repository/authentication_repo.dart';
import 'package:tiktok_clone/features/onboarding/interest_screen.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/utils.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo); //initialize the _authRepo.
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);

    state = await AsyncValue.guard(() async {
      final usercredential = await _authRepo.emailsignUp(
        form["email"],
        form["password"],
      );
      if (usercredential.user != null) {
        await users.createProfile(usercredential);
      }
    }); // AsyncValue.guard throw Future function and if there is any problem it will make state in error. if there is no problem it will return future with data.
    // state = AsyncValue.data(null); // when the loading is finished depose the loading state.
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.goNamed(InterestScreen.routename);
    }
  }
}

final signUpForm = StateProvider((ref) =>
    {}); //StateProvider expose the value that can modified from outside.

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
