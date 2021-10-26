import 'package:college_canteens/screens/admin_homepage.dart';
import 'package:college_canteens/screens/authenticate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/user_homepage.dart';
import 'screens/signin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => Authenticate(),
        '/user': (context) => UserHomePage(),
        '/admin': (context) => AdminHomePage()
      },
    );
  }
}
