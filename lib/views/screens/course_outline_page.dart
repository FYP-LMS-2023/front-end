import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/views/widgets/markdown_text.dart';

class CourseOutlinePage extends StatelessWidget {
  String? syllabus;

  CourseOutlinePage({Key? key, this.syllabus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Course Outline",
            style: Styles.titleLarge,
            //textAlign: TextAlign.center,
          ),
          const VerticalSpacer(),
          FormattedTextWidget(markdownText: syllabus ?? "No Syllabus Yet"),
          // Text(
          //   syllabus ?? "No Syllabus Yet",
          //   style: Styles.bodyLarge,
          // ),
        ],
      ),
    );
  }
}
