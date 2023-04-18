import 'package:flutter/material.dart';
import 'package:front_end/utils/widgets/headers.dart';

class AssignmentListPage extends StatelessWidget {
  const AssignmentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseHeader(
        title: "Assignments",
        subtitle: "CS150 - Final Year Project",
        onMenuPressed: () {},
      ),
      body: const Center(
        child: Text("Assignment List Page"),
      ),
    );
  }
}
