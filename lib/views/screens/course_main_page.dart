import 'package:flutter/material.dart';
import 'package:front_end/entities/class_entity.dart';
import '../screens/course_outline_page.dart';
import '../screens/course_overview_page.dart';
import '../screens/assignment_list_page.dart';
import '../screens/announcment_list_page.dart';
import '../screens/quiz_list_page.dart';
import '../screens/attendance_page.dart';
import '../screens/resource_list_page.dart';
import '../widgets/headers.dart';
import '../../../views/widgets/drawer.dart';

// ignore: must_be_immutable
class CourseMainPage extends StatefulWidget {
  final ClassEntity myclass;
  String currentTab;

  CourseMainPage({
    super.key,
    required this.myclass,
    this.currentTab = "Overview",
  });

  @override
  State<CourseMainPage> createState() => _CourseMainPageState();
}

class _CourseMainPageState extends State<CourseMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerWidget(
        courseCode: widget.myclass.courseCode,
        courseName: widget.myclass.courseName,
        teacherName: widget.myclass.teacherName,
        onOptionSelected: (String option) {
          setState(() {
            widget.currentTab = option;
          });
        },
        tabSelected: widget.currentTab,
      ),
      appBar: CourseHeader(
        title: "${widget.myclass.courseCode} - ${widget.myclass.courseName}",
        onMenuPressed: () {},
      ),
      body: createPage(widget.currentTab),
    );
  }

  createPage(String currentTab) {
    switch (currentTab) {
      case "Overview":
        return const CousrseOverviewPage();
      case "Outline":
        return const CourseOutlinePage();
      case "Attendance":
        return const AttendancePage();
      case "Quizzes":
        return const QuizListPage();
      case "Assignments":
        return const AssignmentListPage();
      case "Announcements":
        return const AnnouncementListPage();
      case "Resources":
        return const ResourceListPage();
    }
  }
}
