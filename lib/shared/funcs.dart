import 'package:flutter/material.dart';

Future<void> showTextSnackbar(
  context,
  String? text,
) async {
  await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text!),
    duration: Duration(seconds: 3),
  ));
}
