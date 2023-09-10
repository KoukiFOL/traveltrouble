import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../Compornents/sideMenu.dart';
import '../service/firebase/auth_service.dart';
import '../service/firebase/database_service.dart';

// 投稿登録画面
class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);
    final auth = Provider.of<AuthService>(context);

    final TextEditingController postController = TextEditingController();

    return Scaffold(
      body: Container(
        child: Column(children: [
          SizedBox(
            width: 10,
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                onPressed: () {
                  final uid = auth.getCurrentUserDataFromFirestore() as String;
                  final post = postController.text;
                  final from = 'China';
                  final to = 'Japan';

                  print('uid: $uid');
                  print('post: $post');
                  // 投稿をFirestoreに追加
                  // その後、ホーム画面へ遷移

                  database.addPostToFirestore(uid, from, post, to);
                  context.goNamed('home');
                },
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
          const Row(children: <Widget>[
            SizedBox(
              width: 10,
            ),
            CircleAvatar(
              radius: 18,
            ),
            SizedBox(
              width: 15,
            ),
            Column(children: <Widget>[
              Text(
                'from',
                style: TextStyle(fontSize: 14),
              ),
              DropdownButtonMenu(key: Key('dropdown1')),
            ]),
            SizedBox(
              width: 8,
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: Image(image: AssetImage('../assets/plane.png')),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              children: <Widget>[
                Text(
                  'to',
                  style: TextStyle(fontSize: 14),
                ),
                DropdownButtonMenu(key: Key('dropdown2')),
              ],
            )
          ]),
          TextFormField(
            controller: postController,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: "What's trable?"),
          ),
        ]),
      ),
    );
  }
}
