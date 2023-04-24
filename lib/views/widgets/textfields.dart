import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  final String label;
  const MainTextField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
    );
  }
}
