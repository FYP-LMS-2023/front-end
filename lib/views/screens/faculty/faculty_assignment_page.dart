import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/assignment_controller.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/models/assignment_model.dart';
import 'package:front_end/utils/functions/create_file_icon.dart';
import 'package:front_end/utils/functions/url_launcher.dart';
import 'package:front_end/views/screens/faculty/faculty_edit_assignment.dart';
import 'package:front_end/views/screens/faculty/faculty_submissions_list.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/markdown_text.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:provider/provider.dart';

class FacAssignmentPage extends StatefulWidget {
  final String? id;
  // final int? numStuds;
  const FacAssignmentPage({super.key, this.id});

  @override
  State<FacAssignmentPage> createState() => _FacAssignmentPageState();
}

class _FacAssignmentPageState extends State<FacAssignmentPage> {
  AssignmentModel? assignment;
  bool loading = true;
  int? numSubs = 0;
  int? numStuds;

  Future<void> fetchAssignmentDetails() async {
    // Log.i("fetching assignment details");
    try {
      await context
          .read<AssignmentController>()
          .getAssignmentDetailsFaculty(widget.id != null ? widget.id! : "1")
          .then((value) {
        setState(() {
          loading = false;
          assignment = context.read<AssignmentController>().getAssignmentObject;
          // Log.v(assignment!.submissions.length);
        });
      });
      await context
          .read<AssignmentController>()
          .getNumSubmissions(widget.id != null ? widget.id! : "1")
          .then((value) {
        setState(() {
          numSubs = context.read<AssignmentController>().getNumSubs;
        });
      });
      // Log.d("assignment details: ${assignment!.title}");
    } catch (e) {
      Log.e("error araha fetch assignment details me $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAssignmentDetails();
  }

  @override
  Widget build(BuildContext context) {
    numStuds = context.read<ClassController>().getMyClass!.studentList.length;
    return loading
        ? Scaffold(body: Loading())
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: CourseHeader(
              title: assignment != null ? assignment!.title : "Assignment 1",
              subtitle: "Assignment",
              onMenuPressed: () {},
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FacEditAssignmentPage(
                        assignment: assignment != null ? assignment! : null,
                        id: widget.id != null ? widget.id! : "1",
                      ),
                    ),
                  );
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    children: <Widget>[
                      AssignmentDetailCard(
                        dueDate: assignment?.dueDate ??
                            DateTime(2021, 05, 04, 20, 20),
                        numResubmissions: 4,
                        resubmissionDueDate: DateTime(2023, 05, 04, 20, 20),
                        status: assignment != null
                            ? assignment!.status
                            : "<status!>",
                        marks: assignment != null ? assignment!.marks : 0,
                      ),
                      const VerticalSpacer(),
                      const Subheading(text: "Instructions"),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(16.0),
                        decoration: boxDecoration,
                        child: FormattedTextWidget(
                          markdownText: assignment != null
                              ? assignment!.description
                              : "This means description is not coming",
                        ),
                      ),
                      const VerticalSpacer(),
                      const Subheading(text: "Files"),
                      assignment?.files == null
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "No files to download",
                                style: Styles.bodyMedium,
                              ),
                            )
                          : Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Please download the following files to complete the assignment.",
                                style: Styles.bodyMedium,
                              ),
                            ),
                      const VerticalSpacer(),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount:
                            assignment != null ? assignment!.files!.length : 0,
                        separatorBuilder: (context, index) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              launchInBrowser(
                                  Uri.parse(assignment!.files![index].url));
                            },
                            child: Ink(
                              decoration: boxDecoration,
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.13,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.13,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: createFileIcon(assignment!
                                          .files![index].url
                                          .split("-")
                                          .last
                                          .split(".")[1]),
                                    ),
                                    const HorizontalSpacer(),
                                    Expanded(
                                      child: Text(
                                        assignment!.files![index].url
                                            .split("/")[8]
                                            .split("-")[1]
                                            .replaceAll('%20', ' '),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const VerticalSpacer(),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.all(16),
              child: MainButton(
                // onPressed: numSubs! == 0 ? null : navigate,
                onPressed: numSubs! == 0
                    ? null
                    : () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FacSubmissionsListPage(
                              id: widget.id != null ? widget.id! : "1",
                            ),
                          ),
                        ),
                text: "View Submissions - $numSubs out of ${numStuds ?? 0}",
                color: Colors.green,
              ),
            ),
          );
  }
}
