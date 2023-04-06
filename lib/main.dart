import 'package:flutter/material.dart';
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
              // MainButton(text: "Submit", onPressed: () {}),
              // HomeOverviewCard(
              //   title: "Course 1",
              //   subtitle: "Final Year Project",
              //   leading: Checkbox(
              //     value: true,
              //     onChanged: (value) => {},
              //   ),
              //   trailing: const CourseProgress(
              //     progress: 75,
              //   ),
              // ),
              // CourseOverviewCard(
              //   type: "assignment",
              //   title: assignment.title,
              //   date: assignment.dueDate,
              //   status: assignment.status,
              //   description: assignment.description,
              //   postedBy: assignment.teacherName,
              // ),
              // CourseOverviewCard(
              //   type: "quiz",
              //   title: quiz.title,
              //   date: quiz.dueDate,
              //   status: quiz.status,
              //   progress: QuizProgress(
              //     answeredQuestions: 1,
              //     totalQuestions: quiz.questions.length,
              //   ),
              // ),
              // CourseOverviewCard(
              //   type: "announcement",
              //   title: announcement.title,
              //   date: announcement.uploadDate,
              //   description: announcement.description,
              //   postedBy: announcement.postedBy,
              // ),
              // AssignmentDetailCard(
              //   dueDate: DateTime.now(),
              //   numResubmissions: 2,
              //   resubmissionDueDate: DateTime.now(),
              //   status: "Submitted",
              // ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  const CenteredCard(
                    text: "Mark Attendance",
                    icon: Icon(Icons.qr_code),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CenteredCard(
                          text: "students",
                          number: mockClass.students.length,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: DetailCard(
                          teacherName: mockClass.teacherName,
                          details: [
                            {"label": "Class", "value": mockClass.semester},
                            {"label": "TA", "value": mockClass.ta![0]["name"]},
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
