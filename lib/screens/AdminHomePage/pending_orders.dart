import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> ordersStream =
      FirebaseFirestore.instance
          .collection('Colleges/PES - RR/Canteens/13th Floor Canteen/Orders')
          .where("isServed", isEqualTo: false)
          .orderBy("timestamp", descending: true)
          .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: ordersStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          final orders = snapshot.requireData.docs;

          return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var order = orders[index];
                Map items = order['items'];
                return order == null
                    ? Container()
                    : Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${order['user']} - Rs ${order['price']}\n"),
                                Text("Orders:"),
                                for (var key in items.keys)
                                  Text(
                                      "${key} - ${items[key]['quantity'].toString()}")
                              ],
                            ),
                          ),
                        ),
                      );
              });
        });
  }
}
