import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:traveltrouble/Compornents/appTitle.dart';
import '../Compornents/dialog.dart';
import '../service/firebase/auth_error.dart';
import '../service/firebase/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

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
            TitleComponent(),
            SizedBox(
              //Email form
              width: 327,
              height: 57,

              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "E-mail",
                  icon: Icon(Icons.person_2),
                ),
              ),
            ),
            const SizedBox(
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                  icon: Icon(Icons.key),
                ),
              ),
            ),
            const SizedBox(
              //空白
              width: 327,
              height: 90,
            ),
            SizedBox(
              width: 224,
              height: 40,
              child: ElevatedButton(
                style: const ButtonStyle(
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
                child: const Text("LOGIN",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
            const SizedBox(height: 40.0),
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
                  const Text(
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
            const SizedBox(height: 16.0),
            // Googoleでログイン
            SizedBox(
              width: 224,
              height: 40,
              child: ElevatedButton(
                  style: const ButtonStyle(
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
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Image(image: AssetImage('../assets/google.png')),
                      ),
                      SizedBox(width: 10),
                      const Text("Google",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          )),
                    ],
                  )),
            ),
            SizedBox(
              //空白
              width: 327,
              height: 20,
            ),
            TextButton(
                onPressed: () => {context.goNamed('signup')},
                child: const Text('Create Account')),
          ],
        ),
      ),
    );
  }
}
