import 'package:flutter/material.dart';
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
          children: [
            // Eメール入力フィールド
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Eメール'),
            ),
            // パスワード入力フィールド
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'パスワード'),
              obscureText: true, // パスワードを隠す
            ),
            // ログインボタン
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text;
                final password = passwordController.text;
                final user = await authService.signUpWithEmailAndPassword(
                    email, password, context);
                if (user != null) {
                  // ログイン成功時の処理
                  print('ログイン成功: ${user.uid}');
                } else {
                  // ログイン失敗時の処理
                  print('ログイン');
                }
              },
              child: Text('LOGIN'),
            ),
          ],
        ),
      ),
    );
  }
}
