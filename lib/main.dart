import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/utils/widgets/buttons.dart';
import 'package:front_end/utils/widgets/cards.dart';
import 'package:front_end/utils/widgets/headers.dart';
import 'package:front_end/utils/widgets/testWidget.dart';
import 'package:front_end/utils/widgets/textfields.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MASH LMS',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TestHeader(
        id: "18635",
        name: "Shaheer Ahmed",
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MainTextField(label: "Test"),
              const SizedBox(
                height: 64,
              ),
              const CourseCard(
                courseName: "Final Year Project",
                percentageCompleted: 20.7,
              ),
              const ToDoCard(
                title: "System Design Document",
                courseName: "Final Year Project",
                dueDay: "Thursday",
                dueDate: "10-03-23",
              ),
              const FeedbackCard(
                title: "Add Music",
                courseName: "Final Year Project",
                dayPosted: "Wednesday",
                datePosted: "09-02-23",
              ),
              CustomCard(
                title: "This is a test",
                subtitle: "Final Year Project",
                leading: Checkbox(
                  value: false,
                  onChanged: (value) => {},
                ),
                trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Due:',
                  textAlign: TextAlign.right,
                  style: Styles.body_small.copyWith(color: Colors.grey),
                ),
                Text(
                  "Thursday",
                  textAlign: TextAlign.right,
                  style: Styles.body_small.copyWith(color: Colors.grey),
                ),
                Text(
                  "10-03-23",
                  textAlign: TextAlign.right,
                  style: Styles.body_small.copyWith(color: Colors.grey),
                ),
              ],
            ),
              ),
              MainButton(
                text: "Submit",
                onPressed: () {},
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
