// 認証に関する処理を記述
import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../screen/home.dart';
import '../../screen/login.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
  Future<User?> signUpWithEmailAndPassword(
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
        await addUserDataToFirestore(
          user.uid,
          email,
          user.displayName ?? '虎ブッタ',
          from,
        );
        // ログイン成功時の処理
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
      return result.user;
    } catch (e) {
      print("サインアップエラー: $e");
      return null;
    }
  }

  // ログイン
  Future<User?> signInWithEmailAndPassword(
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
      return result.user;
    } catch (e) {
      print("ログインエラー: $e");
      return null;
    }
  }

  // ログアウト
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    print("ログアウト完了");
    // ログアウト後にログイン画面に遷移
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  // FireStoreにユーザーを登録
  Future<void> addUserDataToFirestore(
      String userId, String email, String displayName, String from) async {
    final firestore = FirebaseFirestore.instance;
    print("userID: $userId");
    print("email: $email");
    try {
      await firestore.collection('users').doc(userId).set({
        'email': email,
        'displayName': displayName,
        'from': from,
        // 他のユーザーデータを追加できます
      });
    } catch (e) {
      print('Firestoreへのユーザーデータの追加に失敗しました: $e');
    }
  }
}
