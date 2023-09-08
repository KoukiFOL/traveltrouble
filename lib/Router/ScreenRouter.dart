import 'dart:js';

import 'package:flutter/material.dart';
import 'package:traveltrouble/screen/login.dart';

import '../screen/home.dart';

void homeRouter(context) {
  // ログイン成功時の処理
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
}

void LoginRouter(context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );
}
