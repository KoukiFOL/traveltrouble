import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// セットアップ画面
// 新規登録後に表示される画面
class SetupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('セットアップ画面'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'セットアップ画面',
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
