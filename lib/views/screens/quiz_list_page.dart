import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/drop_shadow.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/views/screens/quiz_page_start.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/subheadings.dart';

class QuizListPage extends StatelessWidget {
  const QuizListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            children: <Widget>[
              buildStats(context),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.05,
              // ),
              const VerticalSpacer(),
              const Subheading(text: "Quizzes"),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                clipBehavior: Clip.none,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CourseOverviewCard(
                        type: "quiz",
                        title: 'Quiz ${index + 1}',
                        date: DateTime.now(),
                        postedBy: "Umair Azfar",
                        // progress: const QuizProgress(
                        //   totalQuestions: 27,
                        //   answeredQuestions: 13,
                        // ),
                        onClick: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const QuizPageStart(),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildStats(context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: (size.width - ((size.width * 0.05) * 4)) / 3,
          height: (size.width - ((size.width * 0.05) * 4)) / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Palette.kToDark[50],
            boxShadow: dropShadow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.01),
              Text('${20}%',
                  style: Styles.headlineLarge.copyWith(color: Colors.white)),
              Text(
                "Current",
                style: Styles.labelLarge.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Container(
          width: (size.width - ((size.width * 0.05) * 4)) / 3,
          height: (size.width - ((size.width * 0.05) * 4)) / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: dropShadow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.01),
              Text('${40}%', style: Styles.headlineLarge),
              Text(
                "Weightage",
                style: Styles.labelLarge,
              ),
            ],
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Container(
          width: (size.width - ((size.width * 0.05) * 4)) / 3,
          height: (size.width - ((size.width * 0.05) * 4)) / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: dropShadow),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.01),
              Text('${25}', style: Styles.headlineLarge),
              Text(
                "/${50} Points",
                style: Styles.labelLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
