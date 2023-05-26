import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/views/screens/faculty/announcements/facult_announcement_list.dart';
import 'package:front_end/views/screens/faculty/assignment/faculty_assignment_list.dart';
import 'package:front_end/views/screens/faculty/attendance/faculty_attendance_sessions_list.dart';
import 'package:front_end/views/screens/faculty/faculty_course_outline.dart';
import 'package:front_end/views/screens/faculty/faculty_course_overview.dart';
import 'package:front_end/views/screens/faculty/quiz/faculty_quiz_list.dart';
import 'package:front_end/views/screens/faculty/resources/faculty_resource_list.dart';
import 'package:front_end/views/screens/threads_list.dart';
import 'package:front_end/views/widgets/drawer.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:provider/provider.dart';

class FacCourseMainPage extends StatefulWidget {
  String? id;
  String currentTab;
  FacCourseMainPage({
    super.key,
    this.currentTab = "Overview",
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
        ? const Loading()
        : Scaffold(
            backgroundColor: backgroundColor,
            appBar: CourseHeader(
              title: widget.currentTab,
              subtitle:
                  "${classData!.course!.courseCode} - ${classData!.course!.courseName}",
              onMenuPressed: () {},
            ),
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
        return FacAttendanceSessionsListPage(
            classID: widget.id != null ? widget.id! : "1");
      case "Quizzes":
        return FacQuizListPage(
          id: widget.id != null ? widget.id! : "1",
        );
      case "Assignments":
        return FacAssignmentListPage(
            id: widget.id, fullName: classData!.teacher!.fullName);
      case "Announcements":
        return FacAnnouncementListPage(widget.id,
            fullname: classData!.teacher!.fullName);
      case "Resources":
        return FacResourceListPage(id: widget.id != null ? widget.id! : "1");
      case "Channel":
        return ThreadsList(id: classData!.channel!.channelId);
    }
  }
}
