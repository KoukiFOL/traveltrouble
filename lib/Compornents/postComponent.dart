// 投稿のコンポーネント

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostComponent extends StatelessWidget {
  final String post;
  final String displayName;
  final String from;
  final String to;
  final String date;

  const PostComponent(
      {Key? key,
      required this.post,
      required this.displayName,
      required this.from,
      required this.to,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 141,
        padding: EdgeInsets.all(12),
        // alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(221, 158, 158, 158),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                SizedBox(
                  child: Text(
                    displayName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'SF Pro Text',
                      height: 0.53,
                      letterSpacing: -0.32,
                    ),
                  ),
                ),
                // 日付を表示
                const SizedBox(
                  width: 150,
                ),
                SizedBox(
                  child: Text(
                    date,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'SF Pro Text',
                      height: 0.53,
                      letterSpacing: -0.32,
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            // fromを表示
            Row(
              children: [
                SizedBox(
                  child: Text(from),
                ),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 12,
                  height: 12,
                  child: Image(image: AssetImage('../assets/plane.png')),
                ),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  child: Text(to),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                child: Text(post),
              ),
            ),
          ],
        ));
  }
}
