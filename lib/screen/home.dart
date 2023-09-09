import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltrouble/Compornents/header.dart';

// タイムライン画面
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
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
