import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/UserHomePage.dart';
import 'screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/user',
      routes: {
        '/login': (context) => Login(),
        '/user': (context) => UserHomePage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

