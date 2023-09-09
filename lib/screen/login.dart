// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../Compornents/dialog.dart';
import '../service/firebase/auth_error.dart';
import '../service/firebase/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              //title
              width: 239,
              height: 43,
              child: Text(
                'とらぶった〜',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontFamily: 'SF Pro Text',
                  fontWeight: FontWeight.w700,
                  height: 0.53,
                  letterSpacing: -0.32,
                ),
              ),
            ),
            SizedBox(
              width: 113,
              height: 113,
            ),
            SizedBox(
              //Email form
              width: 327,
              height: 57,

              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "E-mail",
                  icon: Icon(Icons.person_2),
                ),
              ),
            ),
            SizedBox(
              //空白
              width: 327,
              height: 41,
            ),
            SizedBox(
              //password form
              width: 327,
              height: 57,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                  icon: Icon(Icons.key),
                ),
              ),
            ),
            SizedBox(
              //空白
              width: 327,
              height: 90,
            ),
            SizedBox(
              width: 224,
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                ),
                onPressed: () async {
                  final email = emailController.text;
                  final password = passwordController.text;
                  final result = await authService.signInWithEmailAndPassword(
                      email, password, context);
                  print('result: $result');

                  if (result == FirebaseAuthResultStatus.Successful) {
                    context.goNamed('home');
                  } else {
                    final errorMessage = exceptionMessage(result!);
                    showErrorDialog(context, errorMessage);
                  }
                },
                child: Text("LOGIN",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
            SizedBox(
              width: 327,
            ),
            TextButton(
                onPressed: () => {context.goNamed('signup')},
                child: Text('Create Account')),
          ],
        ),
      ),
    );
  }
}
