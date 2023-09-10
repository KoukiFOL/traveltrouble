import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../Compornents/postComponent.dart';
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
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return PostComponent(); // PostComponentのインスタンスを返す
                },
                childCount: 10, // 10個の要素を表示
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.goNamed('post');
          },
          child: Icon(Icons.add),
        ));
  }
}
