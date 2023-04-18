import 'package:flutter/material.dart';
import 'package:front_end/utils/widgets/headers.dart';

class CourseOutlinePage extends StatelessWidget {
  const CourseOutlinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseHeader(
        title: "Course Outline",
        subtitle: "CS150 - Final Year Project",
        onMenuPressed: () {},
      ),
      body: const Center(
        child: Text("Course Outline Page"),
      ),
    );
  }
}
