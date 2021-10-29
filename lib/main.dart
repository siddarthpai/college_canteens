import 'package:college_canteens/screens/admin_homepage.dart';
import 'package:college_canteens/screens/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
      initialRoute: '/init',
      routes: {
        '/auth': (context) => Authenticate(),
        '/user': (context) => UserHomePage(),
        '/admin': (context) => AdminHomePage(),
        '/init': (context) => InitializerWidget()
      },
    );
  }
}

class InitializerWidget extends StatefulWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  FirebaseAuth? _auth;
  User? _user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth!.currentUser;
    isLoading = false;
    if (_user == null) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacementNamed(context, '/auth');
      });
    } else {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacementNamed(context, '/user', arguments: {
          "usrdata": {
            'username': "sachith@gmail",
            'password': "sachith",
            'Balance': 1670,
            'isAdmin': false
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
