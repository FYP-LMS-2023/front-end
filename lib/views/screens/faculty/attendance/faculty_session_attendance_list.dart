import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/controllers/attendance_controller.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/models/attendance_model.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FacAttendanceListPage extends StatefulWidget {
  final Session session;
  const FacAttendanceListPage({super.key, required this.session});

  @override
  State<FacAttendanceListPage> createState() => _FacAttendanceListPage();
}

class _FacAttendanceListPage extends State<FacAttendanceListPage> {
  String? classID;
  String? courseCode;
  String? courseName;
  void toggle(
    int index,
  ) {
    context.read<AttendanceController>().toggleAttendance(
      {
        "classID": classID,
        "studentID": widget.session.attendance[index].studentId!.id,
        "date": widget.session.date,
      },
    ).then(
      (value) {
        if (value == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Attendance Marked"),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Attendance Marking Failed"),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
          setState(() {
            widget.session.attendance[index].present = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    classID = context.read<ClassController>().getMyClass!.id;
    courseCode = context.read<ClassController>().getMyClass!.course!.courseCode;
    courseName = context.read<ClassController>().getMyClass!.course!.courseName;
    Log.i(widget.session);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CourseHeader(
        onMenuPressed: () {},
        title: DateFormat("EE, dd MMMM, yyyy").format(widget.session.date!),
        subtitle: '${courseCode} - ${courseName}',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            children: [
              const Subheading(
                text: "Attendance List",
              ),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  );
                },
                itemCount: widget.session.attendance.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Ink(
                      padding: EdgeInsets.all(16),
                      decoration: boxDecoration,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.session.attendance[index].studentId!.fullName} - ${widget.session.attendance[index].studentId!.erp}',
                          ),
                          widget.session.attendance[index].present!
                              ? TextButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.session.attendance[index].present =
                                          false;
                                    });
                                    toggle(index);
                                  },
                                  child: const Text("Mark Absent"),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red),
                                  ),
                                )
                              : TextButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.session.attendance[index].present =
                                          true;
                                    });
                                    toggle(index);
                                  },
                                  child: const Text("Mark Present"),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.green),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
