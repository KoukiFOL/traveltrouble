// 認証に関する処理を記述
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ユーザーの認証状態を監視するストリーム
  Stream<User?> get userStream => _auth.authStateChanges();

  // サインアップ
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("サインアップエラー: $e");
      return null;
    }
  }

  // ログイン
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("ログインエラー: $e");
      return null;
    }
  }

  // ログアウト
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
