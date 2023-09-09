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
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Text('From'),
                DropdownButtonMenu(), // ここにDropdownButtonMenuを追加
                Icon(Icons.arrow_downward),
                Text('To'),
                DropdownButtonMenu(), // ここにDropdownButtonMenuを追加
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
      title: Text(' '),
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

class DropdownButtonMenu extends StatefulWidget {
  const DropdownButtonMenu({Key? key}) : super(key: key);

  @override
  State<DropdownButtonMenu> createState() => _DropdownButtonMenuState();
}

class _DropdownButtonMenuState extends State<DropdownButtonMenu> {
  String isSelectedValue = 'Alfa';

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: const [
        DropdownMenuItem(
          value: 'Alfa',
          child: Text('Alfa'),
        ),
        DropdownMenuItem(
          value: 'Bravo',
          child: Text('Bravo'),
        ),
        DropdownMenuItem(
          value: 'Charlie',
          child: Text('Charlie'),
        ),
        DropdownMenuItem(
          value: 'Delta',
          child: Text('Delta'),
        ),
        DropdownMenuItem(
          value: 'Foxtrot',
          child: Text('Foxtrot'),
        ),
      ],
      value: isSelectedValue,
      onChanged: (String? value) {
        setState(() {
          isSelectedValue = value!;
        });
      },
    );
  }
}
