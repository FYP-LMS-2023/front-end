import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';

class DrawerWidget extends StatefulWidget {
  final String courseCode;
  final String courseName;
  final String teacherName;
  String tabSelected;
  final Function(String)? onOptionSelected;

  DrawerWidget({
    super.key,
    required this.courseCode,
    required this.courseName,
    required this.teacherName,
    required this.tabSelected,
    this.onOptionSelected,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  // var tabSelected = ;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.courseCode, style: Styles.labelMedium),
                Text(widget.courseName, style: Styles.titleMedium),
                Text(widget.teacherName, style: Styles.labelMedium),
              ],
            ),
          ),
          ListTile(
            title: Text(
              "Overview",
              style: Styles.titleMedium,
            ),
            onTap: () {
              widget.onOptionSelected!("Overview");
              Navigator.pop(context);
              setState(() {
                widget.tabSelected = "Overview";
              });
            },
            tileColor:
                widget.tabSelected == "Overview" ? Colors.grey[300] : Colors.white,
          ),
          ListTile(
            title: Text(
              "Outline",
              style: Styles.titleMedium,
            ),
            onTap: () {
              widget.onOptionSelected!("Outline");
              Navigator.pop(context);
              setState(() {
                widget.tabSelected = "Outline";
              });
            },
            tileColor:
                widget.tabSelected == "Outline" ? Colors.grey[300] : Colors.white,
          ),
          ListTile(
            title: Text(
              "Attendance",
              style: Styles.titleMedium,
            ),
            onTap: () {
              setState(() {
                widget.tabSelected = "Attendance";
              });
              widget.onOptionSelected!("Attendance");
              Navigator.pop(context);
            },
            tileColor:
                widget.tabSelected == "Attendance" ? Colors.grey[300] : Colors.white,
          ),
          ListTile(
            title: Text(
              "Quizzes",
              style: Styles.titleMedium,
            ),
            onTap: () {
              setState(() {
                widget.tabSelected = "Quizzes";
              });
              widget.onOptionSelected!("Quizzes");
              Navigator.pop(context);
            },
            tileColor:
                widget.tabSelected == "Quizzes" ? Colors.grey[300] : Colors.white,
          ),
          ListTile(
            title: Text(
              "Assignments",
              style: Styles.titleMedium,
            ),
            onTap: () {
              setState(() {
                widget.tabSelected = "Assignments";
              });
              widget.onOptionSelected!("Assignments");
              Navigator.pop(context);
            },
            tileColor:
                widget.tabSelected == "Assignments" ? Colors.grey[300] : Colors.white,
          ),
          ListTile(
            title: Text(
              "Announcements",
              style: Styles.titleMedium,
            ),
            onTap: () {
              setState(() {
                widget.tabSelected = "Announcements";
              });
              widget.onOptionSelected!("Announcements");
              Navigator.pop(context);
            },
            tileColor: widget.tabSelected == "Announcements"
                ? Colors.grey[300]
                : Colors.white,
          ),
          ListTile(
            title: Text(
              "Resources",
              style: Styles.titleMedium,
            ),
            onTap: () {
              setState(() {
                widget.tabSelected = "Resources";
              });
              widget.onOptionSelected!("Resources");
              Navigator.pop(context);
            },
            tileColor:
                widget.tabSelected == "Resources" ? Colors.grey[300] : Colors.white,
          ),
        ],
      ),
    );
  }
}
