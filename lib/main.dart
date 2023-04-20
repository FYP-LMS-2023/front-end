import 'package:flutter/material.dart';
import 'package:front_end/controllers/announcement_controller.dart';
import 'package:front_end/controllers/assignment_controller.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/controllers/quiz_controller.dart';
import 'package:front_end/utils/screens/login_page.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ClassProvider>(
          create: (_) => ClassProvider(),
        ),
        ChangeNotifierProvider<QuizProvider>(
          create: (_) => QuizProvider(),
        ),
        ChangeNotifierProvider<AnnouncementProvider>(
          create: (_) => AnnouncementProvider(),
        ),
        ChangeNotifierProvider<AssignmentProvider>(
          create: (_) => AssignmentProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ClassProvider>().loadClasses();
    context.read<QuizProvider>().loadQuizzes();
    context.read<AnnouncementProvider>().loadAnnouncements();
    context.read<AssignmentProvider>().loadAssignments();

    return MaterialApp(
      title: 'MASH LMS',
      theme: ThemeData(primarySwatch: Palette.kToDark),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
