import 'package:flutter/material.dart';
import 'package:front_end/utils/screens/login_page.dart';
import '../constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MASH LMS',
      theme: ThemeData(primarySwatch: Palette.kToDark),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
