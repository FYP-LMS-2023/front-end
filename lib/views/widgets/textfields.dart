import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool? obsureText;
  const MainTextField(
      {super.key, required this.label, this.controller, this.obsureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      controller: controller,
      obscureText: obsureText ?? false,
      decoration: InputDecoration(
          focusColor: Colors.black,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          fillColor: Colors.white,
          filled: true,
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[700])),
    );
  }
}
