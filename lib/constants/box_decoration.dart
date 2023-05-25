import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/drop_shadow.dart';

BoxDecoration get boxDecoration {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    // color: Palette.kToDark[900],
    color: surfaceColor,
    // color: Colors.white,
    // color: Palette.kToDark[50],
    boxShadow: dropShadow,
  );
}
