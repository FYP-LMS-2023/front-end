import 'package:flutter/material.dart';
import 'package:front_end/utils/screens/login_page.dart';
import 'package:front_end/utils/widgets/buttons.dart';
import 'package:front_end/utils/widgets/headers.dart';
import 'package:front_end/utils/widgets/cards.dart';
import '../constants/colors.dart';
import '../models/mock_data.dart';

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

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   bool pressed = false;
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//         appBar: ProfileHeader(id: "18635", name: "Shaheer Ahmed"),
//         body: LoginPage());
//   }
// }
