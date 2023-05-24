import 'package:flutter/material.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/views/screens/announcement_list_page.dart';
import 'package:front_end/views/screens/assignment_list_page.dart';
import 'package:front_end/views/screens/course_outline_page.dart';
import 'package:front_end/views/screens/course_overview_page.dart';
import 'package:front_end/views/screens/faculty/faculty_assignment_list.dart';
import 'package:front_end/views/screens/faculty/faculty_course_outline.dart';
import 'package:front_end/views/screens/faculty/faculty_course_overview.dart';
import 'package:front_end/views/screens/quiz_list_page.dart';
import 'package:front_end/views/screens/resource_list_page.dart';
import 'package:front_end/views/screens/threads_list.dart';
import 'package:front_end/views/screens/view_attendance.dart';
import 'package:front_end/views/widgets/drawer.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:provider/provider.dart';

class FacCourseMainPage extends StatefulWidget {
  String? id;
  String currentTab;
  FacCourseMainPage({
    super.key,
    this.currentTab = "Assignments",
    this.id,
  });

  @override
  State<FacCourseMainPage> createState() => _FacCourseMainPageState();
}

class _FacCourseMainPageState extends State<FacCourseMainPage> {
  bool loading = true;
  ClassModel? classData;

  loadClass() async {
    await context
        .read<ClassController>()
        .getClassDetails(widget.id != null ? widget.id! : "1")
        .then((value) {
      setState(() {
        loading = false;
        classData = context.read<ClassController>().getMyClass;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadClass();
    Log.e('step 2: ${widget.id}');
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(
            body: Loading(),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            endDrawer: classData == null
                ? null
                : DrawerWidget(
                    courseCode: classData!.course!.courseCode,
                    courseName: classData!.course!.courseName,
                    teacherName: classData!.teacher!.fullName,
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
                  "${classData!.course!.courseCode} - ${classData!.course!.courseName}",
              onMenuPressed: () {},
            ),
            body: createPage(widget.currentTab),
          );
  }

  createPage(String currentTab) {
    switch (currentTab) {
      case "Overview":
        return FacCourseOverviewPage(
            classData: classData != null ? classData! : ClassModel());
      case "Outline":
        return FacCourseOutlinePage(
          courseOutline:
              classData != null ? classData!.syllabus : "No Outline Uploaded",
        );
      case "Attendance":
        return  ViewAttendanceScreen();
      case "Quizzes":
        return  QuizListPage();
      case "Assignments":
        return FacAssignmentListPage(
            id: widget.id, fullName: classData!.teacher!.fullName);
      case "Announcements":
        return AnnouncementListPage(widget.id,
            fullname: classData!.teacher!.fullName);
      case "Resources":
        return  ResourceListPage();
      case "Channel":
        return ThreadsList(id: classData!.channel!.channelId);
    }
  }
}
