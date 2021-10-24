import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:uuid/uuid.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key, required this.usrdata, required this.updateWallet}) : super(key: key);
  final Map usrdata;
  final Function updateWallet;

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> menuItems =
  FirebaseFirestore.instance.doc('Colleges/PES - RR/Canteens/13th Floor Canteen').snapshots();
  List counts = List.generate(100, (index) => 0);
  int subtotal = 0;
  Map cart = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: menuItems,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          final data = snapshot.requireData.get('Menu');
          Map<String, dynamic> menu = Map<String, dynamic>.from(data);

          return Column(
            children: [
              Expanded(
                flex: 10,
                child: ListView.builder(
                  itemCount: menu.length,
                  itemBuilder: (context, index) {
                    String key = menu.keys.toList()[index];
                    int count = 0;
                    return Container(
                      height: 60,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 20,),
                                Text("${key.toString()} x${counts[index]}"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Rs ${menu[key]['Price'].toString()}"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.add),
                                        iconSize: 20,
                                        color: Colors.orange,
                                        onPressed: () {
                                          setState(() {
                                            counts[index]++;
                                            subtotal += menu[key]['Price'] as int;
                                            cart[key] = {
                                              "quantity" : counts[index],
                                              "price": menu[key]['Price'] as int,
                                              "total_price" : counts[index] * menu[key]['Price'] as int
                                          };
                                          });
                                        },
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.remove),
                                        iconSize: 20,
                                        color: Colors.orange,
                                        onPressed: () {
                                          if (counts[index] != 0){
                                            setState(() {
                                              counts[index]--;
                                              subtotal -= menu[key]['Price'] as int;
                                              if (counts[index]==0 && cart[key]!=null)
                                                {
                                                  cart.remove(key);
                                                }
                                              else if (cart[key]!=null)
                                                {
                                                  cart[key] = {
                                                    "quantity" : counts[index],
                                                    "price": menu[key]['Price'] as int,
                                                    "total_price" : counts[index] * menu[key]['Price'] as int
                                                  };
                                                }
                                            });
                                          }
                                        },
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Card(
                    color: Colors.lime[300],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            Text("Subtotal: Rs ${subtotal}"),
                          ],
                        ),
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () async {
                                String username = widget.usrdata['username'];
                                var event = await FirebaseFirestore.instance.doc('Users/User').get();
                                Map<String, dynamic> users = event.data() as Map<String, dynamic>;
                                int balance = users[username]['Balance'];

                                if (balance < subtotal){
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Alert"),
                                          content: Text("Insuffient balance. Please Recharge Wallet"),
                                          actions: [
                                            TextButton(
                                              child: Text("OK"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      }
                                  );
                                }
                                else {
                                  int newBalance = balance - subtotal;
                                  var _event = await FirebaseFirestore.instance.doc('Users/User');
                                  await _event.update({widget.usrdata['username']: {'Balance': newBalance, "isAdmin": false, "password": widget.usrdata['password']}});
                                  widget.usrdata['Balance'] = newBalance;


                                  var collection = await FirebaseFirestore.instance.collection('Colleges/PES - RR/Canteens/13th Floor Canteen/Orders');
                                  var uuid = Uuid();
                                  collection.doc(uuid.v4().toString())
                                  .set({
                                    "user": username,
                                    "price": subtotal,
                                    "items": cart
                                  }
                                  );

                                  setState(() {
                                    subtotal=0;
                                  });
                                }
                              },
                              child: Text("Pay"),
                            ),
                            SizedBox(width: 20,)
                          ],
                        )

                      ],
                    )
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
