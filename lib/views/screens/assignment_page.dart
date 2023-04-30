import 'package:flutter/material.dart';
import 'package:front_end/views/widgets/cards.dart';
import '../widgets/headers.dart';

class AssignmentPage extends StatelessWidget {
  const AssignmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CourseHeader(
        title: "Assignment 1",
        subtitle: "CS150 - Final Year Project",
        onMenuPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              CenteredCard(text: "Closed", height: 0.07, ),
            ],
          ),
        ),
      ),
    );
  }
}
