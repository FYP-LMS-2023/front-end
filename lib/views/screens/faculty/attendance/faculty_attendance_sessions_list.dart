import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/attendance_controller.dart';
import 'package:front_end/models/attendance_model.dart';
import 'package:front_end/views/screens/faculty/attendance/faculty_session_attendance_list.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FacAttendanceSessionsListPage extends StatefulWidget {
  final String classID;
  const FacAttendanceSessionsListPage({super.key, required this.classID});

  @override
  State<FacAttendanceSessionsListPage> createState() =>
      _FacAttendanceSessionsListPageState();
}

class _FacAttendanceSessionsListPageState
    extends State<FacAttendanceSessionsListPage> {
  bool loading = true;
  AttendanceModel? attendance;

  void loadAttendance() async {
    context
        .read<AttendanceController>()
        .loadAttendance(widget.classID)
        .then((value) {
      setState(() {
        loading = false;
        attendance = context.read<AttendanceController>().getClassAttendance;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadAttendance();
  }

  @override
  Widget build(BuildContext context) {
    loading ? print("loading ") : Log.e(attendance!.sessions.length.toString());
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  children: [
                    const Subheading(
                      text: "Sessions",
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        );
                      },
                      itemCount: attendance!.sessions.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return FacAttendanceListPage(
                                  session: attendance!.sessions[index],
                                );
                              },
                            ));
                          },
                          child: Ink(
                            padding: EdgeInsets.all(16),
                            decoration: boxDecoration,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Session #${index + 1}", style: Styles.bodyLarge,),
                                Text(
                                    "${DateFormat("EEEE, dd MMMM, yyyy").format(attendance!.sessions[index].date!)}")
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
  }
}
