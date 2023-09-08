import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// プロフィール画面
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール画面'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'プロフィール画面',
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
