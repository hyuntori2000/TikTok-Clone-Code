import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/%08videos/video_recording_screen.dart';
import 'package:tiktok_clone/features/Inbox/activity_screen.dart';
import 'package:tiktok_clone/features/Inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/features/Inbox/direct_message.dart';
import 'package:tiktok_clone/features/authentication/%08email_screen.dart';
import 'package:tiktok_clone/features/authentication/log_in_screen.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/onboarding/interest_screen.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';

final router = GoRouter(initialLocation: "/inbox", routes: [
  GoRoute(
    name: SignUpScreen.routeName,
    path: SignUpScreen.routeURL,
    builder: (context, state) => const SignUpScreen(),
  ),
  GoRoute(
    name: LoginScreen.routeName,
    path: LoginScreen.routeURL,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: InterestScreen.routeUrl,
    name: InterestScreen.routename,
    builder: (context, state) => const InterestScreen(),
  ),
  GoRoute(
    path: "/:tab(home|discover|inbox|profile)",
    name: MainNavigationScreen.routename,
    builder: (context, state) {
      final tab = state.params["tab"]!;
      return MainNavigationScreen(tab: tab);
    },
  ),
  GoRoute(
    path: ActivityScreen.routeUrl,
    name: ActivityScreen.routeName,
    builder: (context, state) => const ActivityScreen(),
  ),
  GoRoute(
      path: DirectMessageScreen.routeUrl,
      name: DirectMessageScreen.routeName,
      builder: (context, state) => const DirectMessageScreen(),
      routes: [
        GoRoute(
          path: ChatScreen.routeUrl,
          name: ChatScreen.routeName,
          builder: (context, state) {
            final chatId = state.params["chatId"]!;
            return ChatScreen(
              chatId: chatId,
            );
          },
        )
      ]),
  GoRoute(
    path: VideoRecordingScreen.routeUrl,
    name: VideoRecordingScreen.routeName,
    pageBuilder: (context, state) => CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 150),
      child: const VideoRecordingScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final position = Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(
          animation,
        );
        return SlideTransition(
          position: position,
          child: child,
        );
      },
    ),
  )
]);
