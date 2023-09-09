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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool item1Selected = false;
  bool item2Selected = false;

  void openDrawerMenu() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void toggleItem1() {
    setState(() {
      item1Selected = !item1Selected;
    });
  }

  void toggleItem2() {
    setState(() {
      item2Selected = !item2Selected;
    });
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
            Column(
              children: [
                Container(
                  color: item1Selected ? Colors.green : Colors.red,
                  child: ListTile(
                    title: GestureDetector(
                      onTap: toggleItem1,
                      child: Text(
                        'メニュー項目1 ${item1Selected ? 'ON' : 'OFF'}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: item2Selected ? Colors.green : Colors.red,
                  child: ListTile(
                    title: GestureDetector(
                      onTap: toggleItem2,
                      child: Text(
                        'メニュー項目2 ${item2Selected ? 'ON' : 'OFF'}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '検索...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
      title: Text('アプリのタイトル'),
      leading: IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          onPressed();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.person), // "person1"のアイコンを追加
          onPressed: () {
            // ボタンが押されたときの処理をここに追加
            // 例えば、プロフィール画面に遷移するなど
          },
        ),
      ],
    );
  }
}
