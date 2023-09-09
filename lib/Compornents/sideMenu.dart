import 'package:flutter/material.dart';

import '../model/country.dart';

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
              Container(
                width: 200,
                alignment: Alignment.centerLeft,
                child: const Text('From'),
              ),
              const DropdownButtonMenu(),
              const SizedBox(height: 7),
              const Icon(Icons.arrow_downward),
              const SizedBox(height: 7),
              Container(
                width: 200,
                alignment: Alignment.centerLeft,
                child: const Text('To'),
              ),
              const DropdownButtonMenu(),
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
  String isSelectedValue = 'Japan';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: DropdownButton(
          isExpanded: true,
          value: isSelectedValue,
          onChanged: (String? value) {
            setState(() {
              isSelectedValue = value!;
            });
          },
          items: countryList.map((String value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));
  }
}
