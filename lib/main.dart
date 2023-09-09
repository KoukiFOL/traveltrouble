import 'package:flutter/material.dart';
import 'package:traveltrouble/Router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:traveltrouble/service/firebase/database_service.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart'; // providerをインポート
import 'service/firebase/auth_service.dart'; // AuthServiceをインポート

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
    return MaterialApp.router(
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
