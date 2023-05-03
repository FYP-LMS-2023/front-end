import 'package:flutter/material.dart ';

import '../widgets/cards.dart';
import 'announcment_page.dart';

class AnnouncementListPage extends StatelessWidget {
  const AnnouncementListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
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
                          type: "announcement",
                          title: 'Announcement ${index + 1}',
                          date: DateTime.now(),
                          postedBy: "Umair Azfar",
                          description:
                              "Hello this is a test description for the assignments",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
