import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/subheadings.dart';

class FacCourseOverviewPage extends StatelessWidget {
  final ClassModel classData;
  const FacCourseOverviewPage({super.key, required this.classData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: CenteredCard(
                    text: "Students",
                    number: classData.studentList.length,
                  ),
                ),
                HorizontalSpacer(),
                Expanded(
                  flex: 2,
                  child: DetailCard(
                    details: [
                      {
                        "label": "Class: ",
                        "value": classData.course!.courseCode,
                      },
                      {
                        "label": "TA: ",
                        "value": classData.ta.isNotEmpty
                            ? classData.ta[0].fullName
                            : "N/A",
                      }
                    ],
                    teacherName: classData.teacher?.fullName,
                  ),
                )
              ],
            ),
            const VerticalSpacer(),
            const Subheading(text: "Latest Assignment"),
            classData.latestAssignment == null || classData.latestAssignment!.title == "<!title>"
                ? Container(
                    height: size.height * 0.05,
                    alignment: Alignment.center,
                    child: Text("No assignments yet",
                        style: Styles.bodySmall.copyWith(color: Colors.grey),
                        textAlign: TextAlign.center),
                  )
                : CourseOverviewCard(
                    type: "assignment",
                    title: classData.latestAssignment == null
                        ? "No assignments yet"
                        : classData.latestAssignment!.title,
                    date: classData.latestAssignment == null || classData.latestAssignment!.dueDate == null
                        ? DateTime.now()
                        : classData.latestAssignment!.dueDate!,
                    description: classData.latestAssignment == null
                        ? "N/A"
                        : classData.latestAssignment!.description,
                    status: classData.latestAssignment == null
                        ? "N/A"
                        : classData.latestAssignment!.status,
                  ),
            const VerticalSpacer(),
            const Subheading(text: "Latest Announcement"),
            classData.latestAnnouncement == null || classData.latestAnnouncement!.title == "<!title>"
                ? Container(
                    height: size.height * 0.05,
                    alignment: Alignment.center,
                    child: Text("No announcements yet",
                        style: Styles.bodySmall
                            .copyWith(color: Color.fromARGB(255, 97, 65, 65)),
                        textAlign: TextAlign.center),
                  )
                : CourseOverviewCard(
                    type: "announcement",
                    title: classData.latestAnnouncement == null
                        ? "No announcements yet"
                        : classData.latestAnnouncement!.title,
                    date: classData.latestAnnouncement == null || classData.latestAnnouncement!.datePosted == null
                        ? DateTime.now()
                        : classData.latestAnnouncement!.datePosted!,
                    description: classData.latestAnnouncement == null
                        ? "N/A"
                        : classData.latestAnnouncement!.description,
                  ),
          ],
        ),
      ),
    );
  }
}
