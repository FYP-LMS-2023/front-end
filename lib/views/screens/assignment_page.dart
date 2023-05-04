import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:front_end/views/widgets/submissions.dart';
import '../widgets/headers.dart';

class AssignmentPage extends StatelessWidget {
  final bool graded;
  const AssignmentPage({super.key, this.graded = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CourseHeader(
        title: "Assignment 1",
        subtitle: "CS150 - Final Year Project",
        onMenuPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Column(
              children: <Widget>[
                AssignmentDetailCard(
                  dueDate: DateTime.now(),
                  numResubmissions: 4,
                  resubmissionDueDate: DateTime(2023, 05, 04, 20, 20),
                  status: "Open",
                ),
                const VerticalSpacer(),
                graded ? const Subheading(text: "Feedback") : const SizedBox(),
                graded
                    ? Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "I think you did alright. But for next time I want work that will will you a nobel piece prize",
                          style: Styles.bodyMedium,
                        ),
                      )
                    : const SizedBox(),
                graded ? const VerticalSpacer() : const SizedBox(),
                const Subheading(text: "Instructions"),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(16.0),
                  decoration: boxDecoration,
                  child: Text(
                    "Join the following repo to start your quiz. \n\nhttps://classroom.github.com/a/9UvwPMC9 \n\nafter joining by your ERP id, clone your repo link to VScode.\nRun these 2 commands first: \n\n - npm init \n - npm install axios bcrypt body-parser dotenv express http-errors jsonwebtoken mongoose morgan nodemon \n - create App.js file and start working as your usual.\n\nYou can use your project database to connect to mongodb.",
                    style: Styles.bodyMedium,
                  ),
                ),
                const VerticalSpacer(),
                const Subheading(text: "Submissions"),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please submit the final documents in PDF format.",
                    style: Styles.bodySmall,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Submissions(),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: !graded
          ? Container(
              padding: const EdgeInsets.all(16),
              child: MainButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "Submit Assignment",
                color: Colors.green,
              ),
            )
          : const SizedBox(),
    );
  }
}
