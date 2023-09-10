import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:traveltrouble/Compornents/postComponent.dart';

import '../model/dateFormat.dart';
import '../service/firebase/auth_service.dart';
import '../service/firebase/database_service.dart';

// プロフィール画面
class ProfileScreen extends StatelessWidget {
  get post => null;

  String displayName = '';
  String from = '';

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final databaseService =
        Provider.of<DatabaseService>(context); // DatabaseServiceを取得

    final uid = authService.currentUser?.uid ?? '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            context.goNamed('home');
          },
          icon: const Image(image: AssetImage('../assets/arrow_left.png')),
        ),
        actions: [
          SizedBox(
            width: 50,
            height: 50,
            child: IconButton(
              icon: const Image(image: AssetImage('../assets/logout.png')),
              onPressed: () {
                // ログアウト処理
                authService.signOut(context);
              },
            ),
          )
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder(
            future: databaseService.getUserDataFromFirestore(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // データをロード中はローディングインジケータを表示
              }
              if (snapshot.hasError) {
                return Text('エラー: ${snapshot.error}');
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return Text('ユーザーデータが見つかりません');
              }
              final userData = snapshot.data?.data() as Map<String, dynamic>;
              displayName = userData['displayName'];
              from = userData['from'];

              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(221, 158, 158, 158),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      child: Text(
                        displayName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'SF Pro Text',
                          fontWeight: FontWeight.w700,
                          height: 0.53,
                          letterSpacing: -0.32,
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const SizedBox(
                        height: 15,
                        width: 15,
                        child: Image(image: AssetImage('../assets/pin.png')),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(child: Text(from)),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Troubles',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 0,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.black,
                  ),
                ],
              );
            },
          ),
          FutureBuilder(
            future: databaseService.getUserPostsFromFirestore(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('エラー: ${snapshot.error}');
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return Text('投稿がありません');
              }
              final userPosts = snapshot.data?.docs ?? [];

              // ユーザの投稿を表示
              return Expanded(
                child: ListView.builder(
                  itemCount: userPosts.length,
                  itemBuilder: (context, index) {
                    final posts =
                        userPosts[index].data() as Map<String, dynamic>;
                    final post = posts['post'] as String;
                    final to = posts['destination'];
                    final timestamp = posts['createdAt'];
                    // dateをDateTimeに変換
                    final date = DateFormat.convertTimeStampToTime(timestamp);

                    return PostComponent(
                      post: post,
                      displayName: displayName,
                      from: from,
                      to: to,
                      date: date,
                    );
                  },
                ),
              );
            },
          ),
        ],
      )),
    );
  }
}
