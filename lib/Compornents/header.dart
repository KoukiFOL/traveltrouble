import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawerMenu() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool item1Selected = false;
  bool item2Selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
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
                DropdownButtonMenu(),
                Icon(Icons.arrow_downward),
                Text('To'),
                DropdownButtonMenu(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget implements PreferredSizeWidget {
  // final Function onPressed;

  // CustomAppBar(this.onPressed);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(' '),
      leading: IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          SideMenu().openDrawerMenu(); // SideMenuクラスのインスタンスを作成してから呼び出す
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            // プロフィール画面に遷移するなどの処理を追加
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
