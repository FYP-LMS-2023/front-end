import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/assignment_controller.dart';
import 'package:front_end/models/assignment_submission_model.dart';
import 'package:front_end/utils/functions/create_file_icon.dart';
import 'package:front_end/utils/functions/url_launcher.dart';
import 'package:front_end/views/screens/faculty/faculty_grade_assignment.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FacViewSubmissionPage extends StatelessWidget {
  final AssignmentSubmissionModel submission;
  const FacViewSubmissionPage({super.key, required this.submission});

  @override
  Widget build(BuildContext context) {
    int marks = context.read<AssignmentController>().assignmentObject!.marks;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CourseHeader(
        title: "Assignment Submission",
        subtitle: submission.studentId!.fullName,
        onMenuPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                  color: submission.returned!
                      ? submission.marksReceived! > 50
                          ? Colors.green
                          : Colors.red
                      : Colors.grey,
                ),
                child: Text(
                  submission.returned!
                      ? "Marks: ${submission.marksReceived} out of $marks"
                      : "Not Returned",
                  style: Styles.bodySmall.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                decoration: boxDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Submitted by: ",
                            style: Styles.titleMedium,
                          ),
                          Text(
                            submission.studentId!.fullName,
                            style: Styles.bodyLarge,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "ERP ID: ",
                            style: Styles.titleMedium,
                          ),
                          Text(
                            submission.studentId!.erp,
                            style: Styles.bodyLarge,
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        children: <Widget>[
                          Text(
                            "Submission Number: ",
                            style: Styles.titleMedium,
                          ),
                          Text(
                            submission.submissionNumber != null
                                ? submission.submissionNumber!.toString()
                                : "1",
                            style: Styles.bodyLarge,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Submitted on: ",
                            style: Styles.titleMedium,
                          ),
                        ],
                      ),
                      Text(
                        DateFormat('dd, MMMM yyyy @ hh:mm a')
                            .format(submission.uploadDate!),
                        style: Styles.bodyLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      submission.returned!
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02)
                          : const SizedBox(),
                      submission.returned!
                          ? Row(
                              children: <Widget>[
                                Text(
                                  "Returned on: ",
                                  style: Styles.titleMedium,
                                ),
                              ],
                            )
                          : const SizedBox(),
                      submission.returned!
                          ? Text(
                              submission.returnDate != null
                                  ? DateFormat('dd, MMMM yyyy @ hh:mm a')
                                      .format(submission.returnDate!)
                                  : "Not Returned",
                              style: Styles.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
              const VerticalSpacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    submission.returned!
                        ? Subheading(text: "Feedback")
                        : const SizedBox(),
                    submission.returned!
                        ? Text(
                            submission.returnDescription!,
                            style: Styles.bodyLarge,
                          )
                        : const SizedBox(),
                    const VerticalSpacer(),
                    const Subheading(text: "Submission Text"),
                    submission.submissionDescription ==
                            "No submission description provided"
                        ? Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "No text to display",
                              style: Styles.bodyMedium
                                  .copyWith(color: Colors.grey[400]),
                            ),
                          )
                        : Text(
                            submission.submissionDescription!,
                            style: Styles.bodyLarge,
                          ),
                    const VerticalSpacer(),
                    const Subheading(text: "Submission Files"),
                    submission.files!.isEmpty
                        ? Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "No files to download",
                              style: Styles.bodyMedium
                                  .copyWith(color: Colors.grey[400]),
                            ),
                          )
                        : const SizedBox(),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: submission.files!.length,
                      separatorBuilder: (context, index) => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            launchInBrowser(
                                Uri.parse(submission.files![index].url));
                          },
                          child: Ink(
                            decoration: boxDecoration,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.13,
                                    height: MediaQuery.of(context).size.width *
                                        0.13,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: createFileIcon(submission
                                        .files![index].url
                                        .split("-")
                                        .last
                                        .split(".")[1]),
                                  ),
                                  const HorizontalSpacer(),
                                  Expanded(
                                    child: Text(
                                      submission.files![index].url
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
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        child: MainButton(
          onPressed: submission.returned!
              ? null
              : () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FacGradeAssignmentPage(
                        id: submission.id!,
                      ),
                    ),
                  );
                },
          text: "Grade Assignment",
          color: Colors.green,
        ),
      ),
    );
  }
}
