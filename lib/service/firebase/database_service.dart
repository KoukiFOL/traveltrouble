// データベースに関する処理を記述

// FireStoreのインポート
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// FireStoreに関する処理を記述するためのクラス
class DatabaseService with ChangeNotifier {
  // FireStoreのインスタンスを作成
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ユーザーのデータを追加
  Future<void> addUserDataToFirestore(
    String uid,
    String email,
    String displayName,
    String from,
  ) {
    // ユーザーのデータを追加
    return _db.collection('users').doc(uid).set({
      'email': email,
      'displayName': displayName,
      'from': from,
    });
  }

  // ユーザーのデータを取得
  Future<DocumentSnapshot> getUserDataFromFirestore(String uid) {
    // ユーザーのデータを取得
    return _db.collection('users').doc(uid).get();
  }
}
