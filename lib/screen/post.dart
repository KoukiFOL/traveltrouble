import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 投稿登録画面
class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('投稿画面'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '投稿画面',
            ),
            ElevatedButton(
              child: Text("ホーム画面へ遷移"),
              onPressed: () {
                context.goNamed('home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
