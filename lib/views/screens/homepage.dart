import 'package:flutter/material.dart';
import 'package:front_end/models/mock_data.dart';
import 'package:front_end/views/screens/assignment_page.dart';
import 'package:front_end/views/screens/course_main_page.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/views/widgets/announcements.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:provider/provider.dart';
import '../../controllers/home_controller.dart';
import '../../models/course_model.dart';
import '../widgets/cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ClassEntity myClass = myClassE;
  bool isChecked = false;
  List<CourseModel>? activeClasses;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
        (_) async => {await context.read<HomeProvider>().getActiveCourses()});
  }

  @override
  Widget build(BuildContext context) {
    activeClasses = context.watch<HomeProvider>().activeClasses;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ProfileHeader(name: "Shaheer Ahmed", id: "18635"),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Subheading(text: "Announcements"),
                const Announcements(),
                const VerticalSpacer(),
                const Subheading(text: "Courses"),
                // HomeOverviewCard(
                //   title: "CS123 - Data Structures",
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) => CourseMainPage(),
                //     ));
                //   },
                // ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.01,
                // ),
                // HomeOverviewCard(
                //   title: 'CS110 - Information Security and Ethics',
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) => CourseMainPage(),
                //     ));
                //   },
                // ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                    itemCount: activeClasses?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final course = activeClasses![index];
                      return HomeOverviewCard(
                        title: '${course.courseCode} - ${course.courseName}',
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CourseMainPage(),
                          ));
                        },
                      );
                    },
                  ),
                ),
                // const VerticalSpacer(),
                // const Subheading(text: "Due Soon"),
                // HomeOverviewCard(
                //   title: "Assignment 1",
                //   subtitle: "Final Year Project",
                //   trailing: CardDueDate(dueDate: DateTime.now()),
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) => const AssignmentPage(),
                //     ));
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
