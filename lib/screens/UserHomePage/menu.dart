import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> menuItems =
  FirebaseFirestore.instance.doc('Colleges/PES - RR/Canteens/13th Floor Canteen').snapshots();

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
          return ListView.builder(
            itemCount: menu.length,
            itemBuilder: (context, index) {
              String key = menu.keys.toList()[index];
              return Container(
                height: 60,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(key.toString()),
                      Text("Rs ${menu[key]['Price'].toString()}"),
                      TextButton(
                          child: Text("Add"),
                          onPressed: () {},
                          )
                    ],
                  )
                ),
              );
            },
          );
        },
      ),
    );
  }
}
