import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../service/firebase/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン'),
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
