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
      'createdAt': Timestamp.now(),
    });
  }

  // ユーザーのデータを取得
  Future<DocumentSnapshot> getUserDataFromFirestore(String uid) {
    // ユーザーのデータを取得
    return _db.collection('users').doc(uid).get();
  }

  // CurrentUserのデータを取得
  Future<DocumentSnapshot> getCurrentUserDataFromFirestore() {
    // ユーザーのデータを取得
    final uid = getCurrentUserDataFromFirestore() as String;
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
    String from,
    String destination,
    String post,
    // List<String> tags,
  ) {
    // 投稿を追加
    // コレクション内容 users/{uid}/posts/{postId}とPosts/{postId}の二つに追加
    return _db
        .collection('users')
        .doc(uid)
        .collection('posts')
        .add({
          'form': from,
          'createdAt': Timestamp.now(),
          'destination': destination,
          'post': post,
          // 'tags': tags,
        })
        .then((value) {
          _db.collection('posts').doc(value.id).set({
            'createdAt': Timestamp.now(),
            'destination': destination,
            'post': post,
            // 'tags': tags,
            'uid': uid,
            'from': from,
          });
        })
        .then((value) => {print("Post Added")})
        .catchError((error) => print("Failed to add post: $error"));
  }

  // Postsコレクションから投稿を一覧で取得
  Future<QuerySnapshot> getPostsFromFirestore() {
    // 投稿を取得
    return _db.collection('posts').get();
  }

  // uidのユーザーの投稿を一覧で取得
  Future<QuerySnapshot> getUserPostsFromFirestore(String uid) {
    // 投稿を取得
    return _db.collection('users').doc(uid).collection('posts').get();
  }
}
