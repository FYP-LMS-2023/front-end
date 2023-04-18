import 'package:flutter/material.dart';
import 'package:front_end/utils/screens/announcment_list_page.dart';
import 'package:front_end/utils/screens/assignment_list_page.dart';
import 'package:front_end/utils/screens/attendance_page.dart';
import 'package:front_end/utils/screens/course_outline_page.dart';
import 'package:front_end/utils/screens/quiz_list_page.dart';
import 'package:front_end/utils/screens/resource_list_page.dart';
import 'package:front_end/utils/widgets/buttons.dart';
import 'package:front_end/utils/widgets/headers.dart';

class CourseOverviewPage extends StatelessWidget {
  const CourseOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseHeader(
        title: "CS150 - Final Year Project",
        onMenuPressed: () {},
        isBack: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Course Overview Page"),
            MainButton(
              text: "Overview",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CourseOverviewPage(),
                  ),
                );
              },
            ),
            MainButton(
              text: "Outline",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CourseOutlinePage(),
                  ),
                );
              },
            ),
            MainButton(
              text: "Attendance",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AttendancePage(),
                  ),
                );
              },
            ),
            MainButton(
              text: "Quizzes",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const QuizListPage(),
                  ),
                );
              },
            ),
            MainButton(
              text: "Assignments",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AssignmentListPage(),
                  ),
                );
              },
            ),
            MainButton(
              text: "Announcements",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AnnouncementListPage(),
                  ),
                );
              },
            ),
            MainButton(
              text: "Resources",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ResourceListPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
