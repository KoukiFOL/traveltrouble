import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../service/firebase/auth_service.dart';
import '../service/firebase/database_service.dart';

// プロフィール画面
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final databaseService =
        Provider.of<DatabaseService>(context); // DatabaseServiceを取得
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
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder(
            future: databaseService
                .getUserDataFromFirestore(authService.currentUser?.uid ?? ''),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // データをロード中はローディングインジケータを表示
              }
              if (snapshot.hasError) {
                return Text('エラー: ${snapshot.error}');
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return Text('ユーザーデータが見つかりません');
              }
              final userData = snapshot.data?.data() as Map<String, dynamic>;
              final displayName = userData['displayName'] as String;
              final from = userData['from'] as String;

              return Column(
                children: [
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
                    SizedBox(
                      child: Text(
                        displayName,
                        style: const TextStyle(
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
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const SizedBox(
                        height: 15,
                        width: 15,
                        child: Image(image: AssetImage('../assets/pin.png')),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(child: Text(from)),
                    ],
                  ),
                  const SizedBox(
                    height: 104,
                  ),
                  const Text('Troubles'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 0,
                    indent: 0,
                    endIndent: 0,
                    color: Colors.black,
                  ),
                ],
              );
            },
          ),
        ],
      )),
    );
  }
}
