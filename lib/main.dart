import 'package:flutter/material.dart';
import 'package:front_end/views/screens/login_page.dart';
import '../constants/colors.dart';

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
      // home: ViewAttendanceScreen(courseName: "Math"),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
