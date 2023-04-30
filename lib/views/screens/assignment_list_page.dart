import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/views/screens/assignment_page.dart';
import 'package:front_end/views/widgets/cards.dart';

class AssignmentListPage extends StatelessWidget {
  const AssignmentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              buildStats(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  clipBehavior: Clip.none,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CourseOverviewCard(
                          type: "assignment",
                          title: 'Assignment ${index + 1}',
                          date: DateTime.now(),
                          postedBy: "Umair Azfar",
                          description:
                              "Hello this is a test description for the assignments",
                          status: "open",
                          onClick: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AssignmentPage(),
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
