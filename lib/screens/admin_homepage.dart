import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> ordersStream =
      FirebaseFirestore.instance.collection('Colleges/PES - RR/Canteens/13th Floor Canteen/Orders').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Canteen Admin"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: ordersStream,
    builder: (context, snapshot) {
    if (snapshot.hasError) {
    return Text("Something went wrong");
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Text("Loading");
    }

    final orders = snapshot.requireData.docs;
    //Map<String, dynamic> menu = Map<String, dynamic>.from(data);

    return  ListView.builder(
    itemCount: orders.length,
    itemBuilder: (context, index) {
      var order = orders[index];
      Map items = order['items'];
      List<Widget> wlist =[];
      items.keys.toList().forEach((key) {
        wlist.add( Text("${key} - ${items[key]['quantity'].toString()}"));
      });
      return order==null ? Container() : Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${order['user']} - Rs ${order['price']}\n"),
                Text("Orders:"),
                ...wlist
              ],
            ),
          ),
        ),
      );
    }
    );
  }));
  }
}
