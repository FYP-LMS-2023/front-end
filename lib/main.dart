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
import 'controllers/announcement_controller.dart';
import 'controllers/assignment_controller.dart';
import 'controllers/channel_controller.dart';
import 'controllers/comment_controller.dart';
import 'controllers/home_controller.dart';
import 'controllers/reply_controller.dart';
import 'controllers/thread_controller.dart';
import 'views/screens/splash_screen.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>(create: (_) => HomeController()),
        ChangeNotifierProvider<QuizController>(create: (_) => QuizController()),
        ChangeNotifierProvider<UserController>(create: (_) => UserController()),
        ChangeNotifierProvider<ClassController>(
            create: (_) => ClassController()),
        ChangeNotifierProvider<AssignmentController>(
            create: (_) => AssignmentController()),
        ChangeNotifierProvider<AnnouncementController>(
            create: (_) => AnnouncementController()),
        ChangeNotifierProvider<ChannelController>(
            create: (_) => ChannelController()),
        ChangeNotifierProvider<ResourceController>(
            create: (_) => ResourceController()),
        ChangeNotifierProvider<AttendanceController>(
            create: (_) => AttendanceController()),
        ChangeNotifierProvider<QuizController>(create: (_) => QuizController()),
        ChangeNotifierProvider<ThreadController>(
            create: (_) => ThreadController()),
        ChangeNotifierProvider<CommentController>(
            create: (_) => CommentController()),
        ChangeNotifierProvider<ReplyController>(
            create: (_) => ReplyController()),
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
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
