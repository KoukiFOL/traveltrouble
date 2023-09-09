import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawerMenu() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(openDrawerMenu),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            DrawerTextField(),
            ListTile(
              title: Text('ドロワーメニュー項目1'),
              onTap: () {
                // ドロワーメニュー項目1がタップされたときの処理
              },
            ),
            ListTile(
              title: Text('ドロワーメニュー項目2'),
              onTap: () {
                // ドロワーメニュー項目2がタップされたときの処理
              },
            ),
            // 他のメニュー項目を追加

            // テキストフィールドを含むDrawerのカスタムウィジェット
          ],
        ),
      ),
      // ページの本文部分をここに配置
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function onPressed;

  CustomAppBar(this.onPressed);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('とらぶった～'),
      leading: IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}

class DrawerTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: '検索ワードを入力......',
        ),
      ),
    );
  }
}
