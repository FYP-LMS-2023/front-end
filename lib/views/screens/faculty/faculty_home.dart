import 'package:flutter/material.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/controllers/home_controller.dart';
import 'package:front_end/controllers/user_controller.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/models/user_model.dart';
import 'package:front_end/views/screens/faculty/faculty_course_main.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:provider/provider.dart';

class FacHome extends StatefulWidget {
  const FacHome({super.key});

  @override
  State<FacHome> createState() => _FacHomeState();
}

class _FacHomeState extends State<FacHome> {
  UserModel? user;
  bool loading = true;
  List<ClassModel>? activeClasses;

  void loadDash() async {
    await context.read<HomeController>().getFacultyDashboard();
    setState(() {
      loading = false;
      activeClasses = context.read<HomeController>().getActiveClasses;
      user = context.read<UserController>().getUser;
    });
  }

  @override
  void initState() {
    super.initState();
    loadDash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ProfileHeader(
        name: "Dr Shaheer",
        id: "18635",
        profilePicture: user != null ? user!.profilePic : "<!profilePic>",
      ),
      body: loading
          ? Loading()
          : SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Subheading(
                      text: "Courses",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: activeClasses?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              HomeOverviewCard(
                                title:
                                    '${activeClasses![index].course!.courseCode} - ${activeClasses![index].course!.courseName}',
                                // title: 'CS 101 - Introduction to Programming',
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      Log.e(
                                          'step 1: ${activeClasses![index].id}');
                                      return FacCourseMainPage(
                                        id: activeClasses != null
                                            ? activeClasses![index].id
                                            : "1",
                                      );
                                    },
                                  ));
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
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
