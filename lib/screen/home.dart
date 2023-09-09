import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../service/firebase/auth_service.dart';
import 'package:traveltrouble/Compornents/sideMenu.dart';

// タイムライン画面
class HomeScreen extends StatelessWidget {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(Icons.search)),
        title: Text('タイムライン'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // プロフィール画面に遷移するなどの処理を追加
            },
          ),
        ],
      ),
      drawer: SideMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ホーム画面',
            ),
            ElevatedButton(
              child: Text("ログイン画面へ遷移"),
              onPressed: () {
                // ログアウト処理
                authService.signOut(context);
              },
            ),
            ElevatedButton(
              child: Text("投稿画面へ遷移"),
              onPressed: () {
                context.goNamed('post');
              },
            ),
          ],
        ),
      ),
    );
  }
}
