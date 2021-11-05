import 'package:college_canteens/screens/AdminHomePage/pending_orders.dart';
import 'package:college_canteens/screens/AdminHomePage/served_orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Canteen Admin"),
          actions: [
            TextButton(
              child: const Text(
                "Sign Out",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                await _auth.signOut();
                Navigator.popAndPushNamed(context, '/auth');
              },
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Served"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [PendingOrders(), ServedOrders()],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
              ),
            ],
          ),
          child: BottomNavigationBar(
            elevation: 50.0,
            currentIndex: 0,
            backgroundColor: Colors.lightGreen,
            selectedItemColor: Colors.black,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.food_bank), label: "Orders"),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "Menu")
            ],
          ),
        ),
      ),
    );
  }
}
