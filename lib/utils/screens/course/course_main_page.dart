import 'package:flutter/material.dart';
import 'package:front_end/entities/class_entity.dart';
import 'package:front_end/utils/screens/announcment_list_page.dart';
import 'package:front_end/utils/screens/assignment_list_page.dart';
import 'package:front_end/utils/screens/attendance_page.dart';
import 'package:front_end/utils/screens/course_outline_page.dart';
import 'package:front_end/utils/screens/course_overview_page.dart';
import 'package:front_end/utils/screens/quiz_list_page.dart';
import 'package:front_end/utils/screens/resource_list_page.dart';
import 'package:front_end/utils/widgets/drawer.dart';
import 'package:front_end/utils/widgets/headers.dart';

class CourseMainPage extends StatefulWidget {
  final ClassEntity myClass;
  String currentTab;

  CourseMainPage({
    super.key,
    required this.myClass,
    this.currentTab = "Quizzes",
  });

  @override
  State<CourseMainPage> createState() => _CourseMainPageState();
}

class _CourseMainPageState extends State<CourseMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerWidget(
        courseCode: widget.myClass.course["courseCode"],
        courseName: widget.myClass.course["courseName"],
        teacherName: widget.myClass.teacher["fullName"],
        onOptionSelected: (String option) {
          setState(() {
            widget.currentTab = option;
          });
        },
        tabSelected: widget.currentTab,
      ),
      appBar: CourseHeader(
        title: widget.currentTab,
        subtitle:
            "${widget.myClass.course["courseCode"]} - ${widget.myClass.course["courseName"]}",
        onMenuPressed: () {},
      ),
      body: createPage(widget.currentTab),
    );
  }

  createPage(String currentTab) {
    switch (currentTab) {
      case "Overview":
        return CousrseOverviewPage(
          myClass: widget.myClass,
        );
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
