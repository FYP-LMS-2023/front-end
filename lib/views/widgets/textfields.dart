import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool? obsureText;
  final String? Function(String?)? validator;
  final int? maxLines;
  final Function? onChange;

  const MainTextField(
      {super.key,
      required this.label,
      this.controller,
      this.obsureText,
      this.validator,
      this.maxLines = 1,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onChanged: (value) {
        onChange != null ? onChange!(value) : null;
      },
      cursorColor: Colors.black,
      controller: controller,
      validator: validator,
      obscureText: obsureText ?? false,
      decoration: InputDecoration(
        focusColor: Colors.black,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 1, color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 1, color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 1, color: Colors.red),
        ),
        fillColor: Colors.white,
        filled: true,
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[700]),
      ),
    );
  }
}
