import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'UserHomePage/menu.dart';
import 'UserHomePage/wallet.dart';

class UserHomePage extends StatefulWidget{
  const UserHomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int currIndex=0;
  Map usrdata = {};

  void updateWallet() async {
    var event = await FirebaseFirestore.instance.doc('Users/User').get(usrdata['username']);
    setState(() {
      usrdata = event.data() as Map<String, dynamic>;
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    usrdata = arguments['usrdata'];
    return Scaffold(
    appBar: AppBar(
      title: Text("College Canteens")
    ),
      body: Stack(
        children: [
          Offstage(
            offstage: currIndex != 0,
            child: Menu(usrdata: usrdata, updateWallet: updateWallet,),
          ),
          Offstage(
            offstage: currIndex != 1,
            child: Wallet(username: usrdata['username'],),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
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
