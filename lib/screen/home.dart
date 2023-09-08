import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// タイムライン画面
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                context.goNamed('login');
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
