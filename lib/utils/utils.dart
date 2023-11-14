import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String msz) {
  final message = SnackBar(
    content: Text(msz),
    backgroundColor: Colors.grey,
    duration: Duration(seconds: 1),
  );
  ScaffoldMessenger.of(context).showSnackBar(message);
}
