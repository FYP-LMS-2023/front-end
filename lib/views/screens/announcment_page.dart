import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants/fonts.dart';
import '../../utils/functions/status_color.dart';
import '../widgets/headers.dart';


class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseHeader(
        title: "Announcment 1",
        subtitle: "CS150 - Final Year Project",
        onMenuPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          Container(
            padding: const EdgeInsets.all(4.0),
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16.0),
                color: status_color("open")),
            child: Text(
              "Exam",
              style: Styles.bodySmall.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "Date Posted: ",
                        style: Styles.labelMedium,
                      ),
                      Text(
                        DateFormat('dd, MMMM yyyy @ hh:mm a').format(DateTime.now()),
                        style: Styles.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Text(
                        "Posted By: ",
                        style: Styles.labelMedium,
                      ),
                      Text(
                        "Umair Azfar Khan",
                        style: Styles.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Title: ",
                        style: Styles.labelLarge,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    const Text("New Learning Management System (LMS)"),
                    SizedBox(height: 10.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description: ",
                        style: Styles.labelLarge,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    const Text("Dear students,\n\nWe are excited to announce the launch of our new Learning Management System (LMS)! Our LMS is designed to provide a more interactive and engaging learning experience for you, with a user-friendly interface and a variety of features that will make your learning journey more enjoyable. With our LMS, you can easily access your course materials, participate in discussions, take quizzes and exams, and collaborate with your peers. You can also track your progress and receive personalized feedback from your instructors to help you stay on track. We are committed to providing you with the best possible learning experience, and we believe that our new LMS will help us achieve that goal. We encourage you to explore the system and take advantage of all the resources available to you. Thank you for choosing our institution for your educational needs, and we look forward to supporting you in your academic pursuits. \n\nBest regards,\nIBA")
              ],
            ),
          )
          ],
        ),
      )
    );
  }
}
