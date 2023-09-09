import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 新規登録画面
class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新規登録画面'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '新規登録画面',
            ),
            ElevatedButton(
              child: Text("ログイン画面へ遷移"),
              onPressed: () {
                context.goNamed('login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
