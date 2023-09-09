import 'package:flutter/material.dart';
import 'package:traveltrouble/Router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:traveltrouble/screen/home.dart';
import 'package:traveltrouble/service/firebase/database_service.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart'; // providerをインポート
import 'service/firebase/auth_service.dart'; // AuthServiceをインポート
import 'screen/login.dart';

void main() {
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()), // AuthServiceを提供
        ChangeNotifierProvider(
            create: (_) => DatabaseService()), // OtherServiceを提供
        // 他のProviderも必要に応じて追加できます
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
