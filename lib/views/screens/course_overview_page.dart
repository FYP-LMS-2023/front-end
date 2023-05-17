import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import '../../constants/spacers.dart';

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
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(classData.course!.courseDescription,
                    style: Styles.bodyLarge, textAlign: TextAlign.center),
              ),
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
              classData.assignments.isEmpty
                  ? Container(
                      height: size.height * 0.05,
                      alignment: Alignment.center,
                      child: Text("No assignments yet",
                          style: Styles.bodySmall.copyWith(color: Colors.grey),
                          textAlign: TextAlign.center),
                    )
                  : CourseOverviewCard(
                      type: "assignment",
                      title:
                          "YAYAYAYAYAYAYAYA THIS IS OUR VERY FIRST ASSIGNMENT YAYAYAYAYAYAYAYA",
                      date: DateTime.now(),
                      postedBy: "postedBy",
                      description: "description",
                      status: "status",
                    ),
              const VerticalSpacer(),
              const Subheading(text: "Latest Announcement"),
              classData.announcement.isEmpty
                  ? Container(
                      height: size.height * 0.05,
                      alignment: Alignment.center,
                      child: Text("No announcements yet",
                          style: Styles.bodySmall.copyWith(color: Colors.grey),
                          textAlign: TextAlign.center),
                    )
                  : CourseOverviewCard(
                      type: "announcement",
                      title: classData.announcement.isNotEmpty
                          ? classData.announcement[0].title
                          : "No announcements yet",
                      date: classData.announcement.isEmpty
                          ? DateTime.now()
                          : classData.announcement[0].datePosted!,
                      postedBy: classData.announcement.isEmpty
                          ? "N/A"
                          : classData.announcement[0].postedBy!.fullName,
                      description: classData.announcement.isEmpty
                          ? "N/A"
                          : classData.announcement[0].description,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
