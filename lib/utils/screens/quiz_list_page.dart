import 'package:flutter/material.dart';
import 'package:front_end/utils/widgets/headers.dart';

class QuizListPage extends StatelessWidget {
  const QuizListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseHeader(
        title: "Quizzes",
        subtitle: "CS150 - Final Year Project",
        onMenuPressed: () {},
      ),
      body: const Center(
        child: Text("Quiz List Page"),
      ),
    );
  }
}
