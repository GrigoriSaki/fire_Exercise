import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String hintText;
  bool obscureText;
  TextEditingController controller;
  MyTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade700, fontSize: 20)),
      obscureText: obscureText,
    );
  }
}
