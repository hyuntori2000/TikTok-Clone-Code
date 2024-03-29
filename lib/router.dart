import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/%08videos/video_recording_screen.dart';
import 'package:tiktok_clone/features/authentication/%08email_screen.dart';
import 'package:tiktok_clone/features/authentication/log_in_screen.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/onboarding/interest_screen.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const VideoRecordingScreen(),
  )
]);
