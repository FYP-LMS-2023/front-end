import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/utils/screens/quiz_page_start.dart';
import 'package:front_end/utils/widgets/cards.dart';
import 'package:front_end/utils/widgets/drawer.dart';
import 'package:front_end/utils/widgets/headers.dart';

class QuizListPage extends StatelessWidget {
  const QuizListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              buildStats(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  clipBehavior: Clip.none,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CourseOverviewCard(
                          type: "quiz",
                          title: 'Quiz ${index  + 1}',
                          date: DateTime.now(),
                          postedBy: "Umair Azfar",
                          progress: const QuizProgress(
                            totalQuestions: 27,
                            answeredQuestions: 13,
                          ),
                          onClick: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const QuizPageStart(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  "Weightage: ",
                  style: Styles.labelMedium,
                ),
                Text(
                  "50%",
                  style: Styles.bodySmall,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Current %: ",
                  style: Styles.labelMedium,
                ),
                Text(
                  "25%",
                  style: Styles.bodySmall,
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              children: [
                Text(
                  "Points Obtained: ",
                  style: Styles.labelMedium,
                ),
                Text(
                  "100",
                  style: Styles.bodySmall,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Total Points: ",
                  style: Styles.labelMedium,
                ),
                Text(
                  "50",
                  style: Styles.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// SingleChildScrollView(
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: <Widget>[
//               Text(
//                 myClass.course["courseDescription"],
//               ),
//               SizedBox(
//                 height: height * 0.05,
//               ),
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                     flex: 1,
//                     child: CenteredCard(
//                       text: "Students",
//                       number: myClass.studentList.length,
//                     ),
//                   ),
//                   SizedBox(
//                     width: width * 0.03,
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: DetailCard(
//                       details: [
//                         {
//                           "label": "Class: ",
//                           "value": myClass.course["courseCode"],
//                         },
//                         {
//                           "label": "TA: ",
//                           "value": myClass.ta[0]["fullName"],
//                         }
//                       ],
//                       teacherName: myClass.teacher["fullName"],
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: height * 0.03,
//               ),
//               Container(
//                 alignment: Alignment.centerLeft,
//                 padding: EdgeInsets.only(left: 8.0),
//                 child: Text(
//                   "Latest Assignment",
//                   style: Styles.labelMedium,
//                 ),
//               ),
//               SizedBox(
//                 height: height * 0.01,
//               ),
//               CourseOverviewCard(
//                 type: "assignment",
//                 title: myClass.assignments[latestAssignment]["title"],
//                 date: myClass.assignments[latestAssignment]["dueDate"],
//                 postedBy: myClass.teacher["fullName"],
//                 description: myClass.assignments[latestAssignment]
//                     ["description"],
//                 status: myClass.assignments[latestAssignment]["status"],
//               ),
//               SizedBox(
//                 height: height * 0.03,
//               ),
//               Container(
//                 alignment: Alignment.centerLeft,
//                 padding: const EdgeInsets.only(left: 8.0),
//                 child: Text(
//                   "Latest Announcement",
//                   style: Styles.labelMedium,
//                 ),
//               ),
//               SizedBox(
//                 height: height * 0.01,
//               ),
//               CourseOverviewCard(
//                 type: "announcement",
//                 title: myClass.announcements[latestAnnouncement]["title"],
//                 date: myClass.announcements[latestAnnouncement]["datePosted"],
//                 postedBy: myClass.announcements[latestAnnouncement]["postedBy"]
//                     ["fullName"],
//                 description: myClass.announcements[latestAnnouncement]
//                     ["description"],
//               ),
//             ],
//           ),
//         ),
//       ),
