import 'package:flutter/material.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/models/class_model.dart';
// import 'package:front_end/entities/class_entity.dart';
import 'package:front_end/views/screens/threads_list.dart';
import 'package:front_end/views/screens/view_attendance.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:provider/provider.dart';
import '../screens/course_outline_page.dart';
import '../screens/course_overview_page.dart';
import '../screens/assignment_list_page.dart';
import 'announcement_list_page.dart';
import '../screens/quiz_list_page.dart';
import '../screens/resource_list_page.dart';
import '../widgets/headers.dart';
import '../../../views/widgets/drawer.dart';

// ignore: must_be_immutable
class CourseMainPage extends StatefulWidget {
  // final ClassEntity myclass;
  String? id;
  String currentTab;

  CourseMainPage({
    super.key,
    // required this.myclass,
    this.currentTab = "Overview",
    this.id,
  });

  @override
  State<CourseMainPage> createState() => _CourseMainPageState();
}

class _CourseMainPageState extends State<CourseMainPage> {
  bool loading = true;
  ClassModel? classData;

  loadClass() async {
    // print(widget.id ?? "1");
    await context
        .read<ClassController>()
        .getClassDetails(widget.id != null ? widget.id! : "1")
        .then(
      (value) {
        setState(() {
          loading = false;
          classData = context.read<ClassController>().getMyClass;
        });
      },
    );
    // setState(() {
    //   loading = false;
    //   classData = context.read<ClassController>().getMyClass;
    // });
  }

  @override
  void initState() {
    super.initState();
    loadClass();
  }

  @override
  Widget build(BuildContext context) {
    return loading ?
        const Scaffold(
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
              subtitle: classData != null ? 
                  "${classData!.course!.courseCode} - ${classData!.course!.courseName}" : "Course Name - Course Code",
              onMenuPressed: () {},
            ),
            body: createPage(widget.currentTab),
          );
  }

  createPage(String currentTab) {
    switch (currentTab) {
      case "Overview":
        return CousrseOverviewPage(classData: classData != null ? classData! : ClassModel());
      case "Outline":
        return const CourseOutlinePage();
      case "Attendance":
        return const ViewAttendanceScreen(
          courseName: "Math",
        );
      case "Quizzes":
        return const QuizListPage();
      case "Assignments":
        return AssignmentListPage(widget.id,fullname: classData!.teacher!.fullName);
      case "Announcements":
        return AnnouncementListPage(widget.id,fullname: classData!.teacher!.fullName);
      case "Resources":
        return const ResourceListPage();
      case "Channel":
        return ThreadsList(id: classData!.channel!.channelId);
    }
  }
}
