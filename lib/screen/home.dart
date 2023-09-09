import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../service/firebase/auth_service.dart';

// タイムライン画面
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム画面'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ホーム画面',
            ),
            ElevatedButton(
              child: Text("ログイン画面へ遷移"),
              onPressed: () {
                // ログアウト処理
                authService.signOut(context);
              },
            ),
            ElevatedButton(
              child: Text("投稿画面へ遷移"),
              onPressed: () {
                context.goNamed('post');
              },
            ),
          ],
        ),
      ),
    );
  }
}
