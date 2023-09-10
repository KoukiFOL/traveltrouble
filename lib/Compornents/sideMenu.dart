import 'package:flutter/material.dart';

// サイドメニューの実装
class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
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
                  textAlignVertical: TextAlignVertical.center,
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
    ));
  }
}

// ドロップダウンメニューの実装
class DropdownButtonMenu extends StatefulWidget {
  const DropdownButtonMenu({Key? key}) : super(key: key);

  @override
  State<DropdownButtonMenu> createState() => _DropdownButtonMenuState();
}

class _DropdownButtonMenuState extends State<DropdownButtonMenu> {
  String isSelectedValue = 'Alfa';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        child: DropdownButton(
          isExpanded: true,
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
        ));
  }
}
