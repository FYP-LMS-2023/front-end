import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';

class CourseOutlinePage extends StatelessWidget {
  const CourseOutlinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Course Outline Page",
            style: Styles.titleLarge,
          ),
          const VerticalSpacer(),
          Text(
            "This is the course outline page. It will contain the course outline of the course. It will be a list of topics and subtopics. The topics will be clickable and will lead to the topic page. The subtopics will be clickable and will lead to the subtopic page. The subtopic page will contain the subtopic content. The topic page will contain the subtopics of the topic. ",
            style: Styles.bodyLarge,
          ),
        ],
      ),
    );
  }
}
