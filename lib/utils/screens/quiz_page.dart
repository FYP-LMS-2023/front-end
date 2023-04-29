import 'package:flutter/material.dart';
import 'package:front_end/utils/widgets/headers.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseHeader(
        title: "Quiz Number 1",
        subtitle: "CS150 - Final Year Project",
        onMenuPressed: () {},
      ),
      body: const Center(
        child: Text("Quiz Page"),
      ),
    );
  }
}
