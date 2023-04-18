import 'package:flutter/material.dart';
import 'package:front_end/utils/widgets/headers.dart';

class ResourceListPage extends StatelessWidget {
  const ResourceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseHeader(
        title: "Resources",
        subtitle: "CS150 - Final Year Project",
        onMenuPressed: () {},
      ),
      body: const Center(
        child: Text("Resources List Page"),
      ),
    );
  }
}
