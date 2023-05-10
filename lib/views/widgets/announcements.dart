import 'package:flutter/material.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/models/announcement_model.dart';
import 'package:front_end/views/screens/announcment_page.dart';

class Announcements extends StatelessWidget {
  final List<AnnouncementModel>? announcementList;
  const Announcements({super.key, required this.announcementList});

  @override
  Widget build(BuildContext context) {
    // print("Announcements: ${announcementList?.map((e) => e.announcementType)}");
    return SizedBox(
      height: (MediaQuery.of(context).size.height / 5) * 0.35,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AnnouncementPage()));
              },
              child: CircleAvatar(
                radius: (MediaQuery.of(context).size.width / 5) * 0.35,
                backgroundColor: Colors.grey[500],
                child: buildIcon(announcementList != null
                    ? announcementList![index].announcementType
                    : "general"),
              ),
            ),
            //jugaar
            if (index != 4) const HorizontalSpacer(),
          ],
        ),
      ),
    );
  }

  Icon buildIcon(String type) {
    // enum: ['general', 'course', 'quiz', 'assignment', 'exam'],
    switch (type) {
      case "general":
        return const Icon(
          Icons.campaign,
          color: Colors.white,
        );
      case "course":
        return const Icon(
          Icons.library_books,
          color: Colors.white,
        );
      case "quiz":
        return const Icon(
          Icons.quiz,
          color: Colors.white,
        );
      case "assignment":
        return const Icon(
          Icons.assignment,
          color: Colors.white,
        );
      case "exam":
        return const Icon(
          Icons.quiz,
          color: Colors.white,
        );

      default:
        return const Icon(
          Icons.campaign,
          color: Colors.white,
        );
    }
  }
}
