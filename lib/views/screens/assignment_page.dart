import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/submissions.dart';
import '../widgets/headers.dart';

class AssignmentPage extends StatelessWidget {
  final bool graded;
  const AssignmentPage({super.key, this.graded = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseHeader(
        title: "Assignment 1",
        subtitle: "CS150 - Final Year Project",
        onMenuPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                AssignmentDetailCard(
                  dueDate: DateTime.now(),
                  numResubmissions: 4,
                  resubmissionDueDate: DateTime(2023, 05, 04, 20, 20),
                  status: "Graded",
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Feedback",
                    style: Styles.labelMedium,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "I think you did alright. But for next time I want work that will will you a nobel piece prize",
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Instructions",
                    style: Styles.labelMedium,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                const Text(
                    "Join the following repo to start your quiz. \n\nhttps://classroom.github.com/a/9UvwPMC9 \n\nafter joining by your ERP id, clone your repo link to VScode.\nRun these 2 commands first: \n\n - npm init \n - npm install axios bcrypt body-parser dotenv express http-errors jsonwebtoken mongoose morgan nodemon \n - create App.js file and start working as your usual.\n\nYou can use your project database to connect to mongodb. "),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Submissions",
                    style: Styles.labelMedium,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: MainButton(
          onPressed: () {
            Navigator.pop(context);
          },
          text: "Submit Assignment",
          color: Colors.green,
        ),
      ),
    );
  }
}
