import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/announcement_controller.dart';
import 'package:front_end/models/announcement_model.dart';
import 'package:front_end/views/screens/announcement_page.dart';
import 'package:front_end/views/screens/faculty/announcements/faculty_add_announcement.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:provider/provider.dart';

import 'faculty_announcement.dart';

class FacAnnouncementListPage extends StatefulWidget {
  String? id;
  String? fullname;
  FacAnnouncementListPage(this.id, {super.key, this.fullname});

  @override
  State<FacAnnouncementListPage> createState() =>
      _FacAnnouncementListPageState();
}

class _FacAnnouncementListPageState extends State<FacAnnouncementListPage> {
  bool loading = true;
  List<AnnouncementModel>? announcements;

  Future<void> fetchAnnouncements() async {
    Log.d("In announcement list page");
    try {
      await context
          .read<AnnouncementController>()
          .getAllAnnouncements(widget.id != null ? widget.id! : "1")
          .then((value) {
        setState(
          () {
            loading = false;
            announcements =
                context.read<AnnouncementController>().getAnnouncements;
            print("Announcements length: ${announcements!.length}");
          },
        );
      });
    } catch (e) {
      Log.e("error araha fetch announcements me: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : SingleChildScrollView(
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Subheading(text: "Announcements"),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return FacAddAnnouncementPage(
                              classID: widget.id != null ? widget.id! : "1",
                            );
                          },
                        ),
                      );
                    },
                    child: Ink(
                      padding: const EdgeInsets.all(4.0),
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          Text(
                            "Add Announcement",
                            style: Styles.titleMedium
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpacer(),
                  announcements == null
                      ? Container(
                          alignment: Alignment.center,
                          child: Text(
                            "No announcements yet",
                            style: Styles.bodySmall.copyWith(
                              color: const Color.fromARGB(255, 97, 65, 65),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount:
                              announcements != null ? announcements!.length : 0,
                          itemBuilder: (context, index) {
                            AnnouncementModel announcement =
                                announcements![index];
                            return CourseOverviewCard(
                              type: announcement.announcementType,
                              title: announcement.title,
                              date: announcement.datePosted ?? DateTime.now(),
                              description: announcement.description,
                              onClick: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => FacAnnouncementPage(
                                      id: announcement.id,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ],
              ),
            ),
          );
  }
}
