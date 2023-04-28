// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:front_end/Custom%20Widgets/custom_widgets.dart';
import 'package:front_end/constants/colors.dart';

class AttendanceScreen extends StatefulWidget {
  final String courseName;

  AttendanceScreen({required this.courseName});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  int presentCount = 0;
  int absenceCount = 0;
  int totalCount = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // Navigate to side menu
          },
          child: const Icon(Icons.menu),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Attendance',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            widget.courseName,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          )
        ]),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.15,
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Image.network(
                        'https://www.investopedia.com/thmb/hJrIBjjMBGfx0oa_bHAgZ9AWyn0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/qr-code-bc94057f452f4806af70fd34540f72ad.png',
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Mark Attendance',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                SizedBox(
                  height: size.height * 0.15,
                  width: size.width * 0.35,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${absenceCount.toString()} \n Absences',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 21),
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                SizedBox(
                  height: size.height * 0.15,
                  width: size.width * 0.5,
                  child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Present: ',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  presentCount.toString(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text(
                                  'Absent:  ',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  absenceCount.toString(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text(
                                  'Total Days:  ',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  totalCount.toString(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ])),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
