import 'package:flutter/material.dart';
import 'package:front_end/controllers/user_controller.dart';
import 'package:front_end/models/announcement_model.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/models/user_model.dart';
import 'package:front_end/views/screens/course_main_page.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/announcements.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:provider/provider.dart';
import '../../controllers/home_controller.dart';
import '../widgets/cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? user;
  bool loading = true;
  List<ClassModel>? activeClasses;
  List<AnnouncementModel>? announcements;

  void loadDash() async {
    await context.read<HomeController>().getDashboard();
    setState(() {
      loading = false;
      activeClasses = context.read<HomeController>().getActiveClasses;
      announcements = context.read<HomeController>().getAnnouncements;
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
    // loadDash();
    // activeClasses = context.watch<DashboardController>().getActiveClasses;
    // announcements = context.watch<DashboardController>().getAnnouncements;
    // user = context.watch<UserController>().user;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: loading
          ? null
          : ProfileHeader(
              name: user != null ? user!.fullName : "<!username>",
              id: user != null ? user!.erp : "<!erp>",
              profilePicture: user != null ? user!.fullName[0] : "<!profilePic>",
            ),
      body: loading
          ? Loading()
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Subheading(text: "Announcements"),
                      Announcements(
                        announcementList: announcements ?? [],
                      ),
                      const VerticalSpacer(),
                      const Subheading(text: "Courses"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: activeClasses?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final currClass = activeClasses![index];
                            // print(currClass.course?.courseCode);
                            return Column(
                              children: [
                                HomeOverviewCard(
                                  title:
                                      '${currClass.course?.courseCode} - ${currClass.course?.courseName}',
                                  // subtitle: currClass.id,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          CourseMainPage(id: currClass.id),
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
            ),
    );
  }
}
