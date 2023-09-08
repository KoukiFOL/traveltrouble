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

  // Postsコレクションに投稿を追加
  // Field {
  // createdAt: 投稿日時
  // destination: 目的地
  // post: 投稿内容
  // tags: タグ (配列)}
  Future<void> addPostToFirestore(
    String uid,
    String destination,
    String post,
    List<String> tags,
  ) {
    // 投稿を追加
    // コレクション内容 users/{uid}/posts/{postId}
    return _db
        .collection('users')
        .doc(uid)
        .collection('posts')
        .add({
          'createdAt': Timestamp.now(),
          'destination': destination,
          'post': post,
          'tags': tags,
        })
        .then((value) => print("投稿を追加しました"))
        .catchError((error) => print("投稿の追加に失敗しました: $error"));
  }
}
