import 'package:flutter/material.dart';
import 'package:front_end/utils/widgets/headers.dart';

class AssignmentPage extends StatelessWidget {
  const AssignmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseHeader(
        title: "Assignment 1",
        subtitle: "CS150 - Final Year Project",
        onMenuPressed: () {},
      ),
      body: const Center(
        child: Text("Assignment Page"),
      ),
    );
  }
}
