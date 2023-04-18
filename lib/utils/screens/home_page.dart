import 'package:flutter/material.dart';
import 'package:front_end/utils/screens/course_overview_page.dart';
import 'package:front_end/utils/widgets/buttons.dart';
import 'package:front_end/utils/widgets/headers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileHeader(
        name: "Shaheer Ahmed",
        id: "18635",
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home Page"),
            MainButton(
              text: "Course 1",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CourseOverviewPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
