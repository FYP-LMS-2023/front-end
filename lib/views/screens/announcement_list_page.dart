import 'package:flutter/material.dart ';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:provider/provider.dart';

import '../../constants/fonts.dart';
import '../../constants/log.dart';
import '../../controllers/announcement_controller.dart';
import '../../models/announcement_model.dart';
import '../widgets/cards.dart';
import 'announcement_page.dart';

class AnnouncementListPage extends StatefulWidget {
  AnnouncementListPage(this.id, {super.key, this.fullname});
  String? id;
  String? fullname;

  @override
  State<AnnouncementListPage> createState() => _AnnouncementListPageState();
}

class _AnnouncementListPageState extends State<AnnouncementListPage> {
  List<AnnouncementModel>? announcements;

  Future<void> fetchAnnouncements() async {
    Log.d("In announcement list page");
    try {
      await context
          .read<AnnouncementController>()
          .getAllAnnouncements(widget.id != null ? widget.id! : "1")
          .then((value) {
        setState(() {
          announcements =
              context.read<AnnouncementController>().getAnnouncements;
          print("Announcements length: ${announcements!.length}");
        });
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

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Subheading(text: "Announcements"),
          announcements == null
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.black,
                ))
              : announcements!.isEmpty
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
                  : Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount:
                            announcements != null ? announcements!.length : 0,
                        itemBuilder: (context, index) {
                          AnnouncementModel announcement =
                              announcements![index];
                          return Column(
                            children: [
                              CourseOverviewCard(
                                type: announcement.announcementType,
                                title: announcement.title,
                                date: announcement.datePosted ?? DateTime.now(),
                                description: announcement.description,
                                status: announcement.announcementType,
                                onClick: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AnnouncementPage(
                                        id: announcement.id,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
