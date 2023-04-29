import 'package:flutter/material.dart';
import 'package:front_end/utils/widgets/headers.dart';

class MarkAttendancePage extends StatelessWidget {
  const MarkAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseHeader(
        title: "Mark Attendance",
        subtitle: "CS150 - Final Year Project",
        onMenuPressed: () {},
      ),
      body: const Center(
        child: Text("Mark Attendance Page"),
      ),
    );
  }
}
