import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// プロフィール画面
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              context.goNamed('home');
            },
            icon: const Image(image: AssetImage('../assets/arrow_left.png')),
          )),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            height: 20,
          ),
          Row(children: [
            const SizedBox(
              width: 20,
            ),
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Color.fromARGB(221, 158, 158, 158),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const SizedBox(
              child: Text(
                'ユーザー名',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'SF Pro Text',
                  fontWeight: FontWeight.w700,
                  height: 0.53,
                  letterSpacing: -0.32,
                ),
              ),
            ),
          ]),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 15,
                width: 15,
                child: Image(image: AssetImage('../assets/pin.png')),
              ),
              SizedBox(
                width: 5,
              ),
              SizedBox(child: Text('Japan')),
            ],
          ),
        ]),
      ),
    );
  }
}
