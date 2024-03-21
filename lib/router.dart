import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    name: SignUpScreen.routeName,
    path: SignUpScreen.routeURL,
    builder: (context, state) => const SignUpScreen(),
    routes: [
      GoRoute(
          path: UsernameScreen.routeURL,
          name: UsernameScreen.routeName,
          builder: (context, state) => const UsernameScreen(),
          routes: [
            GoRoute(
              path: EmailScreen.routeURL,
              name: EmailScreen.routeName,
              builder: (context, state) {
                final args = state.extra as EmailScreenArgs;
                return EmailScreen(username: args.username);
              },
            ),
          ]),
    ],
  ),
  // GoRoute(
  //   path: LoginScreen.routeName, // url 생성자
  //   builder: (context, state) => const LoginScreen(),
  // ),
  // GoRoute(
  //     name: "username_screen",
  //     path: UsernameScreen.routeName,
  //     pageBuilder: (context, state) {
  //       return CustomTransitionPage(
  //           child: const UsernameScreen(),
  //           transitionsBuilder:
  //               (context, animation, secondaryAnimation, child) {
  //             return FadeTransition(
  //                 opacity: animation,
  //                 child: ScaleTransition(
  //                   scale: animation,
  //                   child: child,
  //                 ));
  //           });
  //     }),

  // GoRoute(
  //   path: LoginFormScreen.routeName,
  //   builder: (context, state) => const LoginFormScreen(),
  // ),
  // GoRoute(
  //   path: InterestScreen.routename,
  //   builder: (context, state) => const InterestScreen(),
  // ),
  // GoRoute(
  //   path: MainNavigationScreen.routename,
  //   builder: (context, state) => const MainNavigationScreen(),
  // ),
  // GoRoute(
  //   path: "/users/:username",
  //   builder: (context, state) {
  //     final username = state.params['username'];
  //     final tab = state.queryParams["show"];
  //     return UserProfileScreen(
  //         username: username!,
  //         tab: tab!); //put ! to let flutter know username cannot be a null.
  //   },
  // )
]);
