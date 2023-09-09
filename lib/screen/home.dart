import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/firebase/auth_service.dart';
import '../service/firebase/database_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController postController = TextEditingController();

    final authService = Provider.of<AuthService>(context);
    final databaseService =
        Provider.of<DatabaseService>(context); // DatabaseServiceを取得

    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ホーム'),
            // ユーザーのデータを取得し、displayNameを表示
            FutureBuilder(
              future: databaseService
                  .getUserDataFromFirestore(authService.currentUser?.uid ?? ''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // データをロード中はローディングインジケータを表示
                }
                if (snapshot.hasError) {
                  return Text('エラー: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Text('ユーザーデータが見つかりません');
                }
                final userData = snapshot.data?.data() as Map<String, dynamic>;
                final displayName = userData['displayName'] as String;
                return Text('ようこそ、$displayName さん');
              },
            ),

            TextField(
              controller: postController,
              decoration: InputDecoration(labelText: 'What’s trable?'),
            ),
            // 投稿を入力して投稿ボタンを押すと、投稿を追加
            ElevatedButton(
              onPressed: () async {
                final uid = authService.currentUser?.uid ?? '';
                await databaseService.addPostToFirestore(
                  uid,
                  '東京',
                  postController.text,
                  ['東京', '観光'],
                );
              },
              child: Text('投稿'),
            ),

            // Postsコレクションから投稿一覧を取得
            FutureBuilder(
              future: databaseService.getPostsFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // データをロード中はローディングインジケータを表示
                }
                if (snapshot.hasError) {
                  return Text('エラー: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Text('投稿がありません');
                }
                final posts = snapshot.data?.docs ?? [];
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index].data() as Map<String, dynamic>;
                    final uid = post['uid'] as String;
                    final postText = post['post'] as String;
                    return FutureBuilder(
                        future: databaseService
                            .getUserDataFromFirestore(uid), // uidからユーザーのデータを取得
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('エラー: ${snapshot.error}');
                          }
                          if (!snapshot.hasData || snapshot.data == null) {
                            return Text('ユーザーデータが見つかりません');
                          }
                          final userData =
                              snapshot.data?.data() as Map<String, dynamic>;
                          final displayName = userData['displayName'] as String;
                          return Text('$displayName: $postText');
                        });
                  },
                );
              },
            ),
            // ログアウトボタン
            ElevatedButton(
              onPressed: () async {
                await authService.signOut(context);
              },
              child: Text('LOGOUT'),
            )
          ],
        ),
      ),
    );
  }
}
