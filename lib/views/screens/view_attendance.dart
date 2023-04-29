// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';

class ViewAttendanceScreen extends StatefulWidget {
  final String courseName;

  ViewAttendanceScreen({required this.courseName});

  @override
  _ViewAttendanceScreenState createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  int presentCount = 0;
  int absenceCount = 0;
  int totalCount = 0;
  String kAssetImagePath = "lib/constants/Images/";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Open side menu
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "View Your Attendance",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.courseName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Filter the list
              },
              child: const Text("Filter"),
            ),
          ],
        ),
        body: DefaultTabController(
            length: 2,
            child: Column(children: [
              const TabBar(
                tabs: [
                  Tab(text: "Presents"),
                  Tab(text: "Absences"),
                ],
              ),
              Expanded(
                  child: TabBarView(children: [
                // Presents tab
                ListView.builder(
                  itemCount: 10, // replace with actual data
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      reverse: false,
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Course Name",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("Course Code"),
                                  ],
                                ),
                              ),
                              SizedBox(width: size.width * 0.08),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                child: const Text(
                                  "Teacher Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.1),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                child: const Text(
                                  "Date",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 8,
                            color: Colors.grey,
                            indent: 10,
                            endIndent: 10,
                            thickness: 0.8,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // Absences tab
                ListView.builder(
                  itemCount: 10, // replace with actual data
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      reverse: false,
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Course Name",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("Course Code"),
                                  ],
                                ),
                              ),
                              SizedBox(width: size.width * 0.08),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                child: const Text(
                                  "Teacher Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.1),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                child: const Text(
                                  "Date",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 8,
                            color: Colors.grey,
                            indent: 10,
                            endIndent: 10,
                            thickness: 0.8,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ]))
            ])));
  }
}
