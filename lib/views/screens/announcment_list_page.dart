import 'package:flutter/material.dart ';
import 'package:front_end/views/widgets/subheadings.dart';

import '../widgets/cards.dart';
import 'announcment_page.dart';

class AnnouncementListPage extends StatelessWidget {
  const AnnouncementListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            children: <Widget>[
              const Subheading(text: "Announcements"),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                clipBehavior: Clip.none,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CourseOverviewCard(
                        type: "announcement",
                        title: 'Announcement ${index + 1}',
                        date: DateTime.now(),
                        postedBy: "Umair Azfar",
                        description:
                            "Hello this is a test description for the annouceents",
                        onClick: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AnnouncementPage(),
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
            ],
          ),
        ),
      ),
    );
  }
}
