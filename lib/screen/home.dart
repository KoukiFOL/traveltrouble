import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../Compornents/postComponent.dart';
import '../service/firebase/auth_service.dart';
import 'package:traveltrouble/Compornents/sideMenu.dart';

import '../service/firebase/database_service.dart';

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
    final databese = Provider.of<DatabaseService>(context);
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
            // getPostsFromFirestoreを使って投稿を取得
            // FutureBuilderを使ってデータを取得
            FutureBuilder(
              future: databese.getPostsFromFirestore(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // データが取得できた場合
                if (snapshot.hasData) {
                  // データを取得
                  final posts = snapshot.data.docs;
                  // postsからuidを取得し、ユーザーのデータを取得

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        // 投稿を表示

                        final post = posts[index].data()['post'];
                        final uid = posts[index].data()['uid'];
                        final from = posts[index].data()['from'];
                        final to = posts[index].data()['destination'];

                        return FutureBuilder(
                          future: databese.getUserDataFromFirestore(uid),
                          builder: ((context, snapshot) {
                            if (snapshot.hasData) {
                              final userData =
                                  snapshot.data?.data() as Map<String, dynamic>;
                              final displayName =
                                  userData['displayName'] as String;
                              return PostComponent(
                                post: post,
                                displayName: displayName,
                                from: from,
                                to: to,
                              );
                            }
                            return Container();
                          }),
                        );
                      },

                      childCount: posts.length, // 投稿の数だけ表示
                    ),
                  );
                }
                // データが取得できなかった場合
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    childCount: 1, // 1個の要素を表示
                  ),
                );
              },
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
