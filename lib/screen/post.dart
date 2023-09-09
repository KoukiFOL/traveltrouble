import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 投稿登録画面
class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: Text('cancel'),
                onPressed: () {
                  context.goNamed('home');
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  foregroundColor: Colors.black,
                ),
              ),
              ElevatedButton(
                child: Text("trouble"),
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 2, 0, 0),
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  backgroundColor: Color.fromARGB(255, 177, 241, 175),
                  fixedSize: Size(95, 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
          Row(children: <Widget>[
            CircleAvatar(
              radius: 20,
            ),
            Column(children: <Widget>[
              Text(
                'from',
                style: TextStyle(fontSize: 14),
              ),
              DropdownButton(
                items: const [
                  DropdownMenuItem(
                    value: 'America',
                    child: Text('America'),
                  ),
                  DropdownMenuItem(
                    value: 'China',
                    child: Text('China'),
                  )
                ],
                value: isSelectedValue,
                onChanged: (String? value) {
                  setState(() {
                    isSelectedValue = value!;
                  });
                },
              ),
            ])
          ]),
        ],
      )),
    );
  }
}
