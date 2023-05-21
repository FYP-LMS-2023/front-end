import 'package:flutter/material.dart';
import 'package:front_end/controllers/attendance_controller.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/controllers/quiz_controller.dart';
import 'package:front_end/controllers/resource_controller.dart';
// import 'controllers/quiz_controller.dart';
import 'package:front_end/views/screens/login_page.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../../controllers/user_controller.dart';
import 'controllers/home_controller.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>(create: (_) => HomeController()),
        // ChangeNotifierProvider<QuizController>(create: (_) => QuizController()),
        ChangeNotifierProvider<UserController>(create: (_) => UserController()),
        ChangeNotifierProvider<ClassController>(
            create: (_) => ClassController()),
        ChangeNotifierProvider<ResourceController>(
            create: (_) => ResourceController()),
        ChangeNotifierProvider<AttendanceController>(
            create: (_) => AttendanceController()),
        ChangeNotifierProvider<QuizController>(
            create: (_) => QuizController())
        
      ],
      child: const MyApp(),
    ),
  );
  // runApp(const MyApp());
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
