import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../service/firebase/auth_service.dart';
import 'package:traveltrouble/Compornents/sideMenu.dart';

// タイムライン画面

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: kToolbarHeight,
            pinned: true, // 下スクロール時にAppBarを表示
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: Icon(Icons.search),
            ),
            title: InkWell(
              // InkWellを使用してタップ可能にする
              onTap: () {
                _scrollController.animateTo(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              },
              child: SizedBox(
                width: 35,
                height: 35,
                child: Image(image: AssetImage('assets/tiger.PNG')),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  // プロフィール画面に遷移するなどの処理を追加
                  context.goNamed('profile');
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'ホーム画面',
                    ),
                    Column(
                      children: [
                        // TODO: ここにタイムラインの表示を実装
                        Container(
                          height: 300,
                          color: Colors.blue,
                        ),
                        Container(
                          height: 300,
                          color: Colors.green,
                        ),
                        Container(
                          height: 300,
                          color: Colors.yellow,
                        ),
                        Container(
                          height: 300,
                          color: Colors.orange,
                        ),
                        Container(
                          height: 300,
                          color: Colors.purple,
                        ),
                        Container(
                          height: 300,
                          color: Colors.pink,
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
