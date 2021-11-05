import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_canteens/shared/funcs.dart';
import 'package:flutter/material.dart';

class ChangeMenu extends StatefulWidget {
  const ChangeMenu({Key? key}) : super(key: key);

  @override
  _ChangeMenuState createState() => _ChangeMenuState();
}

class _ChangeMenuState extends State<ChangeMenu> {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> canteenStream =
      FirebaseFirestore.instance
          .doc('Colleges/PES - RR/Canteens/13th Floor Canteen')
          .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: canteenStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.requireData.get("Menu");
          Map<String, dynamic> menu = Map<String, dynamic>.from(data);

          return ListView.builder(
            itemCount: menu.length,
            itemBuilder: (context, index) {
              String key = menu.keys.toList()[index];
              return Container(
                height: 60,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(key),
                        Row(
                          children: [
                            Text("Rs${menu[key]['Price']}"),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.lightGreen,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {},
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
