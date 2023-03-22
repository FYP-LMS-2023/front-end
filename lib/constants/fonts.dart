import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class Fonts {}

class Styles {
  Styles._();

  static final appbarTitle = GoogleFonts.poppins(
    fontSize: 26,
    fontWeight: FontWeight.w700,
  );
  static final logo = GoogleFonts.sansita(
    fontSize: 100,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );
  static final tagLine = GoogleFonts.robotoSerif(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );
  static final tagLineDescription = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );
  static const hint = TextStyle(
    color: Colors.grey,
    fontSize: 20,
  );
  static final inputText = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );
  static final inputTextLocked = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );
  static const banners = TextStyle(
    color: const Color.fromARGB(255, 59, 59, 61),
    fontSize: 40,
    fontWeight: FontWeight.w900,
  );
  static const loginText = TextStyle(
    color: Colors.red,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );
  static const buttonText = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static TextStyle cartButtonText = GoogleFonts.poppins(
      textStyle: TextStyle(
    color: Colors.white,
    fontSize: 17,
    fontWeight: FontWeight.w700,
  ));

  static const orSeperator = TextStyle(
    color: Colors.black54,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static final inputLabel = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  static final subLabel = GoogleFonts.poppins(
    fontSize: 7.5,
    fontWeight: FontWeight.w300,
  );

  static final priceUnit = GoogleFonts.poppins(
    fontSize: 9,
    fontWeight: FontWeight.w300,
  );

  static final priceValue = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static final inputError = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w300,
  );

  static final inputSuffix = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );
  static final pageHeader = GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w800,
  );
}
