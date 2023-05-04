import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/views/screens/quiz_page.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/headers.dart';

class QuizPageStart extends StatelessWidget {
  const QuizPageStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseHeader(
        title: "Quiz Number 1",
        subtitle: "CS150 - Final Year Project",
        onMenuPressed: () {},
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Instructions",
                      style: Styles.headlineSmall,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "We will add some basic instructions here that will be followed for all tests",
                      style: Styles.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: MainButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const QuizPage(),
              ),
            );
          },
          text: "Start Quiz",
          color: Palette.kToDark[50],
        ),
      ),
    );
  }
}
