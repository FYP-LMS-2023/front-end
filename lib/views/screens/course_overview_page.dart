import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import '../../constants/spacers.dart';

class CousrseOverviewPage extends StatelessWidget {
  // final ClassEntity myClass;
  const CousrseOverviewPage({
    super.key,
    // required this.myClass,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            children: <Widget>[
              const Text(
                "This is course description here hahaha good morning",
              ),
              const VerticleSpacer(),
              Row(
                children: const <Widget>[
                  Expanded(
                    flex: 1,
                    child: CenteredCard(
                      text: "Students",
                      number: 24,
                    ),
                  ),
                  HorizontalSpacer(),
                  Expanded(
                    flex: 2,
                    child: DetailCard(
                      details: [
                        {
                          "label": "Class: ",
                          "value": "classID",
                        },
                        {
                          "label": "TA: ",
                          "value": "taName",
                        }
                      ],
                      teacherName: "teacherName",
                    ),
                  )
                ],
              ),
              const VerticleSpacer(),
              const Subheading(text: "Latest Assignment"),
              CourseOverviewCard(
                type: "assignment",
                title: "title",
                date: DateTime.now(),
                postedBy: "postedBy",
                description: "description",
                status: "status",
              ),
              const VerticleSpacer(),
              const Subheading(text: "Latest Announcement"),
              CourseOverviewCard(
                type: "announcement",
                title: "title",
                date: DateTime.now(),
                postedBy: "postedBy",
                description: "description",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
