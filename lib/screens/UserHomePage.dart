import 'package:flutter/material.dart';

import 'UserHomePage/menu.dart';
import 'UserHomePage/wallet.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int currIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text("College Canteens")
    ),
      body: Stack(
        children: [
          Offstage(
            offstage: currIndex != 0,
            child: Menu(),
          ),
          Offstage(
            offstage: currIndex != 1,
            child: Wallet(),
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
