import 'package:flutter/material.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/views/screens/announcment_page.dart';
import 'package:front_end/views/screens/homepage.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import 'views/screens/view_attendance.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ClassProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ClassProvider>().loadClasses();
    return MaterialApp(
      title: 'MASH LMS',
      theme: ThemeData(primarySwatch: Palette.kToDark),
      home: ViewAttendanceScreen(courseName: "Math"),
      debugShowCheckedModeBanner: false,
    );
  }
}
