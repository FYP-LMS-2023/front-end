import 'package:flutter/material.dart';

List<BoxShadow> get dropShadow {
  return [
    BoxShadow(
      color: Colors.grey.withOpacity(0.4),
      blurRadius: 5,
      offset: const Offset(0, 0),
      spreadRadius: 0.15,
      blurStyle: BlurStyle.normal,
    ),
  ];
}
