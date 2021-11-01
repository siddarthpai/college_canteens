import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';

String? auth_register(String username, String password) {
  String? response = null;
}

Future<Map?> auth_signin(String username, String password) async {
  Map? response = null;
  var event = await FirebaseFirestore.instance.doc('Users/User').get();
  Map<String, dynamic> users = event.data() as Map<String, dynamic>;
  print(users);
  if (users[username] == null) {
    response = null;
  } else {
    var user = users[username] as Map;
    print(user);
    if (user['password'].toString() != password) {
      response = null;
    } else {
      user['username'] = username;
      response = user;
    }
  }
  return response;
}
