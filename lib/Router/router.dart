import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltrouble/screen/login.dart';

import '../screen/home.dart';
import '../screen/post.dart';
import '../screen/profile.dart';
import '../screen/setup.dart';
import '../screen/signup.dart';

final goRouter = GoRouter(
  // アプリが起動した時
  initialLocation: '/login',
  // パスと画面の組み合わせ
  routes: [
    // ログイン画面
    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: LoginScreen(),
        );
      },
    ),
    // HOME画面
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: HomeScreen(),
        );
      },
    ),
    // 新規登録画面
    GoRoute(
      path: '/signup',
      name: 'signup',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: SignupScreen(),
        );
      },
    ),
    // 投稿画面
    GoRoute(
      path: '/post',
      name: 'post',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: PostScreen(),
        );
      },
    ),
    // プロフィール画面
    GoRoute(
      path: '/profile',
      name: 'profile',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: ProfileScreen(),
        );
      },
    ),
    // セットアップ画面
    GoRoute(
      path: '/setup',
      name: 'setup',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: SetupScreen(),
        );
      },
    ),
  ],
  // 遷移ページがないなどのエラーが発生した時に、このページに行く
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);
