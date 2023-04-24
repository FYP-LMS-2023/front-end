import 'package:flutter/material.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/views/widgets/announcements.dart';

import '../widgets/cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileHeader(name: "Huzaifa", id: "18591"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text("Announcements", style: Styles.titleMedium.copyWith(color: Colors.black)),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Announcements(),
          ),
          const SizedBox(height: 12,),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text("Courses", style: Styles.titleMedium.copyWith(color: Colors.black)),
          ),
          const HomeOverviewCard(title: 'Final Year Project', trailing: CourseProgress(progress: 60),),
          const HomeOverviewCard(title: 'Information Security and Ethics', trailing: CourseProgress(progress: 80),),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text("To Do List", style: Styles.titleMedium.copyWith(color: Colors.black)),
          ),
          HomeOverviewCard(
            title: "Assignment 1", 
            subtitle: "Final Year Project", 
            leading: Checkbox(value: isChecked, onChanged: (bool? value) { setState(() {
              isChecked = ! isChecked;
            }); }, ),
            trailing: CardDueDate(dueDate: DateTime.now()),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text("Recent Feedback", style: Styles.titleMedium.copyWith(color: Colors.black)),
          ),
          HomeOverviewCard(
            title: "Add System Design", 
            subtitle: "Final Year Project", 
            trailing: CardDate(Date: DateTime.now()),
          ),

        ]
      )
    );

  }
}