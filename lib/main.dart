import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_canteens/screens/admin_homepage.dart';
import 'package:college_canteens/screens/authenticate.dart';
import 'package:college_canteens/shared/funcs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'screens/user_homepage.dart';

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
    route();
  }

  Future<void> route() async {
    if (_user == null) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacementNamed(context, '/auth');
      });
    } else {
      var user = await FirebaseFirestore.instance
          .doc('Users/${_auth!.currentUser!.uid}');
      DocumentSnapshot user_data = await user.get();
      Map usrdata = user_data.data() as Map<String, dynamic>;
      usrdata['username'] = _auth!.currentUser!.uid;
      if (!usrdata['isAdmin']) {
        SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
          Navigator.pushReplacementNamed(context, '/user',
              arguments: {"usrdata": usrdata});
        });
      } else {
        SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
          Navigator.pushReplacementNamed(context, '/admin');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bolt Snacck"),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
