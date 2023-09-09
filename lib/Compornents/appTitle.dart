// アプリのタイトル

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService>(context);
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Image(image: AssetImage('../assets/tiger.PNG')),
        ),
        const SizedBox(
          height: 6,
        ),
        SizedBox(
          //title
          width: 239,
          height: 43,
          child: Text(
            'とらぶった〜',
            textAlign: TextAlign.center,
            style: GoogleFonts.sawarabiGothic(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.w700,
              height: 0.53,
              letterSpacing: -0.32,
            ),
          ),
        ),
        const SizedBox(
          width: 113,
          height: 80,
        ),
      ],
    );
  }
}
