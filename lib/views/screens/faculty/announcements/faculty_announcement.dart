import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../constants/fonts.dart';
import '../../../../constants/log.dart';
import '../../../../controllers/announcement_controller.dart';
import '../../../../models/announcement_model.dart';
import '../../../../utils/functions/status_color.dart';
import '../../../widgets/headers.dart';
import 'faculty_edit_announcement.dart';

class FacAnnouncementPage extends StatefulWidget {
  String? id;
  FacAnnouncementPage({super.key, this.id});

  @override
  State<FacAnnouncementPage> createState() => _FacAnnouncementPageState();
}

class _FacAnnouncementPageState extends State<FacAnnouncementPage> {

  AnnouncementModel? announcement;

  Future<void> fetchAnnouncementDetails() async {
    Log.i("fetching announcement details");
    try {
      await context
          .read<AnnouncementController>()
          .getAnnouncementDetails(widget.id != null ? widget.id! : "1")
          .then((value) {
        setState(() {
          announcement = context.read<AnnouncementController>().getAnnouncementObject;
        });
      });

      Log.d("announcement details: ${announcement!.title}");
    } catch (e) {
      Log.e("error araha fetch announcement details me $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAnnouncementDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: CourseHeader(
          title: "Announcement",
          subtitle: announcement != null ? announcement!.title : "Announcement 1",
          onMenuPressed: () {},
          trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final refresh = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FacEditAnnouncementPage(
                        announcement: announcement != null ? announcement! : null,
                        id: widget.id != null ? widget.id! : "1",
                      ),
                    ),
                  );
                  if (refresh) {
                    fetchAnnouncementDetails();
                  }
                },
              ),
            ),
        body: announcement == null ?
          const Loading() 
          : SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                        color: status_color(announcement != null ? announcement!.announcementType : "Exam")),
                    child: Text(
                      announcement != null ? announcement!.announcementType : "Exam",
                      style: Styles.bodySmall.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: double.infinity,
                    decoration: boxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "Date Posted: ",
                                style: Styles.titleMedium,
                                
                              ),
                            ],
                          ),
                          Text(
                                DateFormat('dd, MMMM yyyy @ hh:mm a')
                                    .format(DateTime.now()),
                                style: Styles.bodyLarge,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Posted By: ",
                                style: Styles.titleMedium,
                              ),
                              Text(
                                "Umair Azfar Khan",
                                style: Styles.bodyLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpacer(),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          announcement != null ? announcement!.title : "Announcement Title Not Coming",
                          style: Styles.titleLarge,
                        ),
                        const VerticalSpacer(),
                        Text(
                          announcement != null ? announcement!.description : "Announcement Description Not Coming",
                          style: Styles.bodyMedium,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
