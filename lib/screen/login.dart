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
            SizedBox(height: 40.0),
            // OR CONNECT WITHのテキストを表示
            SizedBox(
              width: 327,
              height: 20,
              child: Row(
                children: [
                  Container(
                    height: 1, // 棒線の高さを設定
                    color: Colors.black, // 棒線の色を設定
                    width: 150, // 棒線の幅を設定
                  ),
                  Text(
                    ' OR ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    height: 1, // 棒線の高さを設定
                    color: Colors.black, // 棒線の色を設定
                    width: 150, // 棒線の幅を設定
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Googoleでログイン
            SizedBox(
              width: 224,
              height: 40,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(133, 193, 127, 1)),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  onPressed: () async {
                    final result = await authService.signInWithGoogle(context);
                    if (result != null) {
                      context.goNamed('home');
                    } else {
                      showErrorDialog(context, 'Googleログインに失敗しました');
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   'lib/assets/google.svg', // SVGファイルのパス
                      //   width: 20.0, // 幅の指定
                      //   height: 20.0, // 高さの指定
                      // ),
                      Text("Google",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  )),
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
