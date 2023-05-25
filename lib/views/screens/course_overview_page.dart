import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import '../../constants/log.dart';
import '../../constants/spacers.dart';
import 'announcement_page.dart';
import 'assignment_page.dart';

class CousrseOverviewPage extends StatelessWidget {
  // final ClassEntity myClass;
  final ClassModel classData;
  const CousrseOverviewPage({
    super.key,
    // required this.myClass,
    required this.classData,
  });

  @override
  Widget build(BuildContext context) {
    Log.d("Class Name: ${classData.course?.courseName}");
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            children: <Widget>[ 
              const VerticalSpacer(),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: CenteredCard(
                      text: "Students",
                      number: classData.studentList.length,
                    ),
                  ),
                  const HorizontalSpacer(),
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
              classData.latestAssignment == null
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
                      date: classData.latestAssignment == null
                          ? DateTime.now()
                          : classData.latestAssignment!.dueDate!,
                      description: classData.latestAssignment == null
                          ? "N/A"
                          : classData.latestAssignment!.description,
                      status: classData.latestAssignment == null
                          ? "N/A"
                          : classData.latestAssignment!.status,
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AssignmentPage(
                              id: classData.latestAssignment!.id,
                              graded: false,
                            ),
                          ),
                        );
                      },
                    ),
              const VerticalSpacer(),
              const Subheading(text: "Latest Announcement"),
              classData.latestAnnouncement == null
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
                      date: classData.latestAnnouncement == null
                          ? DateTime.now()
                          : classData.latestAnnouncement!.datePosted!,
                      description: classData.latestAnnouncement == null
                          ? "N/A"
                          : classData.latestAnnouncement!.description,
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AnnouncementPage(
                              id: classData.latestAnnouncement!.id,
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
