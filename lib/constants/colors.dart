//palette.dart
import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xffffffff, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff353535), //10%
      100: Color(0xff4b4b4b), //20%
      200: Color(0xff626262), //30%
      300: Color(0xff787878), //40%
      400: Color(0xff8f8f8f), //50%
      500: Color(0xffa5a5a5), //60%
      600: Color(0xffbcbcbc), //70%
      700: Color(0xffd2d2d2), //80%
      800: Color(0xffe9e9e9), //90%
      850: Color(0xfff5f5f5),
      900: Color(0xfffdfdfd), //100%
    },
  );
}

// Color containerColor = const Color.fromARGB(255, 131, 205, 41);
Color backgroundColor = const Color(0xffFFFFFA);
Color surfaceColor = const Color(0xffFFFFFA);
Color darkButtonColor = const Color(0xFF152519);
Color lightButtonColor = const Color(0xFF83CD29);
Color lightGreen = const Color(0xFF83CD29);
Color darkGreen = const Color(0xFF152519);