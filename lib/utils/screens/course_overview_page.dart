import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/entities/class_entity.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/utils/widgets/cards.dart';

class CousrseOverviewPage extends StatelessWidget {
  final ClassEntity myClass;
  const CousrseOverviewPage({
    super.key,
    required this.myClass,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    int latestAssignment = myClass.assignments.length - 1;
    int latestQuiz = myClass.quizzes.length - 1;
    int latestAnnouncement = myClass.announcements.length - 1;
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                myClass.course["courseDescription"],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: CenteredCard(
                      text: "Students",
                      number: myClass.studentList.length,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Expanded(
                    flex: 2,
                    child: DetailCard(
                      details: [
                        {
                          "label": "Class: ",
                          "value": myClass.course["courseCode"],
                        },
                        {
                          "label": "TA: ",
                          "value": myClass.ta[0]["fullName"],
                        }
                      ],
                      teacherName: myClass.teacher["fullName"],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Latest Assignment",
                  style: Styles.labelMedium,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              CourseOverviewCard(
                type: "assignment",
                title: myClass.assignments[latestAssignment]["title"],
                date: myClass.assignments[latestAssignment]["dueDate"],
                postedBy: myClass.teacher["fullName"],
                description: myClass.assignments[latestAssignment]
                    ["description"],
                status: myClass.assignments[latestAssignment]["status"],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Latest Announcement",
                  style: Styles.labelMedium,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              CourseOverviewCard(
                type: "announcement",
                title: myClass.announcements[latestAnnouncement]["title"],
                date: myClass.announcements[latestAnnouncement]["datePosted"],
                postedBy: myClass.announcements[latestAnnouncement]["postedBy"]
                    ["fullName"],
                description: myClass.announcements[latestAnnouncement]
                    ["description"],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
