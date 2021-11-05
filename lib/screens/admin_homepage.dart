import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_canteens/screens/AdminHomePage/pending_orders.dart';
import 'package:college_canteens/screens/AdminHomePage/served_orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

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
          )),
    );
  }
}
