import 'package:flutter/material.dart ';
import 'package:front_end/utils/widgets/headers.dart';

class AnnouncementListPage extends StatelessWidget {
  const AnnouncementListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseHeader(
        title: "Announcements",
        subtitle: "CS150 - Final Year Project",
        onMenuPressed: () {},
      ),
      body: const Center(
        child: Text("Announcment List Page"),
      ),
    );
  }
}
