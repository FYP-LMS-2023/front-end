import 'package:flutter/material.dart';
import 'package:front_end/utils/widgets/headers.dart';
import 'package:front_end/utils/widgets/cards.dart';
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
      appBar: CourseHeader(
        title: "Final Year Project",
        onMenuPressed: () {
          //on pressed functionality
        },
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HomeOverviewCard(
                title: "This is a test",
                subtitle: "Final Year Project",
                leading: Checkbox(
                  value: pressed,
                  onChanged: (value) => {
                    setState(() {
                      pressed = !pressed;
                    })
                  },
                ),
                trailing: CardDueDate(dueDate: DateTime.now()),
              ),
              const HomeOverviewCard(
                title: "Final Year Project",
                trailing: CardProgressIndicator(progress: 67.5),
              ),
              HomeOverviewCard(
                title: "Add Music",
                subtitle: "Final Year Project",
                trailing: CardDueDate(dueDate: DateTime.now()),
              ),
              CourseOverviewCard(
                  type: "assignment",
                  title: "System Design Document",
                  postedBy: "Umair Azfar",
                  date: DateTime.now(),
                  description:
                      "You have to make a document that can perform wonders. Good luck! You will need it.",
                  status: "Not Started"),
              CourseOverviewCard(
                  status: "Assignment",
                  title: "Assignment 1 Posted",
                  postedBy: "Umair Azfar",
                  date: DateTime.now(),
                  description:
                      "Please find the asignment posted in LMS at the worst time possible!",
                  type: "announcment")
            ],
          ),
        ),
      ),
    );
  }
}

final List<Map<String, String>> weekData = [
  {'week': 'Week 1', 'assignment': 'Assignment 1'},
  {'week': 'Week 2', 'assignment': 'Assignment 2'},
  {'week': 'Week 3', 'assignment': ''},
  {'week': 'Week 4', 'assignment': 'Assignment 4'},
  {'week': 'Week 5', 'assignment': 'Assignment 5'},
  {'week': 'Week 6', 'assignment': 'Assignment 6'},
  {'week': 'Week 7', 'assignment': 'Assignment 7'},
  {'week': 'Week 8', 'assignment': 'Assignment 8'},
];
const weekNames = [
  "Week 1",
  "Week 2",
  "Week 3",
  "Week 4",
  "Week 5",
  "Week 6",
  "Week 7",
  "Week 8",
  "Week 9",
  "Week 10",
  "Week 11",
  "Week 12",
];
const assignmentNames = [
  "System Design Document",
  " ",
  "System Design Document",
  "",
  "System Design Document",
  "",
  "System Design Document",
  " ",
  "System Design Document",
  "",
  "System Design Document",
  "",
];
