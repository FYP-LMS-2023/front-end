import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/drop_shadow.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/controllers/attendance_controller.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/models/attendance_model.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ViewAttendanceScreen extends StatefulWidget {
  String? id;

  ViewAttendanceScreen({super.key, this.id});

  @override
  _ViewAttendanceScreenState createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  int totalCount = 28;
  bool loading = true;
  AbsentDays? absents;
  ClassModel? classData;

  Future<void> fetchAttendanceDetails() async {
    Log.i("fetching resources details");
    try {
      await context
          .read<AttendanceController>()
          .getMyAttendance(widget.id != null ? widget.id! : "1")
          .then((value) {
        setState(() {
          loading = false;
          //print(DateFormat('EEEE').format(absents.absentDays));
          DateTime formatDate = DateFormat('dd/MM/yyyy').parse('10/06/2023');
          print(DateFormat('EEEE').format(formatDate));
          absents = context.read<AttendanceController>().getAttendance;
          Log.d(absents);
          classData = context.read<ClassController>().getMyClass;
        });
      });
    } catch (e) {
      Log.e("$e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAttendanceDetails();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return loading
        ? const Center(child: Loading())
        : SingleChildScrollView(
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
                            Text(
                                absents != null
                                    ? (5 - absents!.absentCount).toString()
                                    : "0",
                                style: Styles.headlineLarge
                                    .copyWith(color: Colors.white)),
                            Text(
                              "Leaves Left",
                              style: Styles.labelLarge
                                  .copyWith(color: Colors.white),
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
                            Text(
                                absents != null
                                    ? absents!.absentCount.toString()
                                    : "0",
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
                      'Absents',
                      style: Styles.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: absents != null ? absents!.absentDays.length : 0,
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
                                child: Text(
                                  DateFormat('EEEE').format(
                                      DateFormat('dd/MM/yyyy')
                                          .parse(absents!.absentDays[index])),
                                  style: const TextStyle(
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
                                child: Text(
                                  absents != null
                                      ? absents!.absentDays[index]
                                      : "",
                                  style: const TextStyle(
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
