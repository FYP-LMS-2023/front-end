import 'package:flutter/material.dart';
import 'package:front_end/utils/widgets/buttons.dart';
import 'package:front_end/utils/widgets/headers.dart';
import 'package:front_end/utils/widgets/cards.dart';
import 'package:front_end/utils/widgets/progress_buggy.dart';
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
      home: const MyHomePage(title: 'MASH LMS'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const ProfileHeader(
      //   id: "18635",
      //   name: "Shaheer Ahmed",
      // ),
      appBar: const ProfileHeader(id: "18635", name: "Shaheer Ahmed"),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MainButton(text: "Submit", onPressed: () {}),
              HomeOverviewCard(
                title: "Course 1",
                subtitle: "Final Year Project",
                leading: Checkbox(
                  value: true,
                  onChanged: (value) => {},
                ),
                trailing: const CardProgressIndicator(
                  progress: 75,
                ),
              ),
              CourseOverviewCard(
                type: "quiz",
                title: "SRS",
                date: DateTime(2023, 04, 03, 00, 51),
                status: "Late",
                progress: const QuizProgress(
                    totalQuestions: 30,
                    answeredQuestions: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}

