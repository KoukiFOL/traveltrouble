// 認証に関する処理を記述
import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:traveltrouble/Router/ScreenRouter.dart';

import '../../screen/home.dart';
import '../../screen/login.dart';
import 'auth_error.dart';
import 'database_service.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final database = DatabaseService();

  User? get currentUser => _auth.currentUser;
  bool get isLoggedIn => currentUser != null;

  // ユーザーの認証状態を監視するストリーム
  AuthProvider() {
    // Firebase Authenticationの状態変更をリアルタイムで監視
    _auth.authStateChanges().listen((user) {
      notifyListeners(); // 状態が変化したときにUIを更新
    });
  }

  get isLoading => null;

  // サインアップ
  Future<FirebaseAuthResultStatus> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    print("サインアップ");
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      final from = "Japan";

      if (user != null) {
        await database.addUserDataToFirestore(
          user.uid,
          email,
          user.displayName ?? '虎ブッタ',
          from,
        );
        // ログイン成功時の処理
      }
      return FirebaseAuthResultStatus.Successful;
    } catch (e) {
      print("サインアップエラー: $e");
      final error = handleException(e as FirebaseAuthException);
      return error;
    }
  }

  // ログイン
  Future<FirebaseAuthResultStatus?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      if (user != null) {
        // ログイン成功時の処理
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
      return FirebaseAuthResultStatus.Successful;
    } catch (e) {
      // エラーハンドリングによるエラーメッセージの表示
      final error = handleException(e as FirebaseAuthException);
      print("ログインエラー: $e");
      return error;
    }
  }

  // Googleを使ったログイン
  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      final result = await _auth.signInWithPopup(googleProvider);
      final user = result.user;
      if (user != null) {
        // ログイン成功時の処理
        // Firestoreにユーザー情報を保存
        await database.addUserDataToFirestore(
          user.uid,
          user.email ?? '',
          user.displayName ?? '虎ブッタ',
          'Japan',
        );
      }
      return result.user;
    } catch (e) {
      print("Googleログインエラー: $e");
      return null;
    }
  }

  // ログアウト
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    print("ログアウト完了");
    // ログアウト後にログイン画面に遷移
    LoginRouter(context);
  }
}
