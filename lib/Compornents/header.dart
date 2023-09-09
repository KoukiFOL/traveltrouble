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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: search(),
    );
  }

  AppBar search() {
    return AppBar(
      title: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TextField(
          decoration: InputDecoration(
            //  hintText: 'Search...',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(8.0),
            prefixIcon: Icon(Icons.search), // 検索アイコンを追加
          ),
        ),
      ),
    );
  }
}
