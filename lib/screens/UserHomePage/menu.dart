import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> menuItems =
  FirebaseFirestore.instance.doc('Colleges/PES - RR/Canteens/13th Floor Canteen').snapshots();
  List counts = List.generate(100, (index) => 0);
  int subtotal = 0;

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
                                            subtotal += counts[index] * menu[key]['Price'] as int;
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
                                              subtotal -= counts[index] * menu[key]['Price'] as int;
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
                              onPressed: () {},
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
