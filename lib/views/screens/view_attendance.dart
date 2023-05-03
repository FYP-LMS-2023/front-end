import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/drop_shadow.dart';
import 'package:front_end/constants/fonts.dart';

class ViewAttendanceScreen extends StatefulWidget {
  final String courseName;

  const ViewAttendanceScreen({super.key, required this.courseName});

  @override
  _ViewAttendanceScreenState createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  int presentCount = 24;
  int absenceCount = 3;
  int totalCount = 28;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: (size.width - ((size.width * 0.05) * 4)) / 3,
                  height: (size.width - ((size.width * 0.05) * 4)) / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Palette.kToDark[50],
                    boxShadow: dropShadow,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.01),
                      Text((5 - absenceCount).toString(),
                          style: Styles.headlineLarge
                              .copyWith(color: Colors.white)),
                      Text(
                        "Leaves Left",
                        style: Styles.labelLarge.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: size.width * 0.05),
                Container(
                  width: (size.width - ((size.width * 0.05) * 4)) / 3,
                  height: (size.width - ((size.width * 0.05) * 4)) / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: dropShadow,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.01),
                      Text(absenceCount.toString(),
                          style: Styles.headlineLarge),
                      Text(
                        "Absents",
                        style: Styles.labelLarge,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: size.width * 0.05),
                Container(
                  width: (size.width - ((size.width * 0.05) * 4)) / 3,
                  height: (size.width - ((size.width * 0.05) * 4)) / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: dropShadow),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.01),
                      Text((totalCount).toString(),
                          style: Styles.headlineLarge),
                      Text(
                        "Total Classes",
                        style: Styles.labelLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Absent Dates",
                style: Styles.bodyLarge,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5, // replace with actual data
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          child: const Text(
                            "Absent Day",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.1),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          child: const Text(
                            "Absent Date",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 0.8,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
