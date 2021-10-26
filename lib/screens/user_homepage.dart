import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'UserHomePage/menu.dart';
import 'UserHomePage/wallet.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int currIndex = 0;
  Map usrdata = {};

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    usrdata = arguments['usrdata'];
    return Scaffold(
      appBar: AppBar(
        title: Text("College Canteens"),
        actions: [
          TextButton(
            child: Text(
              "Sign Out",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/auth');
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Offstage(
            offstage: currIndex != 0,
            child: Menu(
              usrdata: usrdata,
            ),
          ),
          Offstage(
            offstage: currIndex != 1,
            child: Wallet(
              username: usrdata['username'],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightGreen,
        selectedItemColor: Colors.black,
        currentIndex: currIndex,
        onTap: (int index) => setState(() {
          currIndex = index;
        }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Order"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: "Wallet")
        ],
      ),
    );
  }
}