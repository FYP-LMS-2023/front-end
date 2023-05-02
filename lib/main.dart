import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../views/screens/login_page.dart';

void main() {
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (_) => ClassProvider(),
  //     child: const MyApp(),
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<ClassProvider>().loadClasses();
    return MaterialApp(
      title: 'MASH LMS',
      theme: ThemeData(primarySwatch: Palette.kToDark),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
