import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ログイン画面
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン画面'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ログイン画面',
            ),
            ElevatedButton(
              child: Text("ログイン"),
              onPressed: () {
                context.goNamed('home');
              },
            ),
            ElevatedButton(
              child: Text("新規登録"),
              onPressed: () {
                context.goNamed('signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}
