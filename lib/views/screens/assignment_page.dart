import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:front_end/views/widgets/submissions.dart';
import 'package:provider/provider.dart';
import '../../constants/log.dart';
import '../../controllers/assignment_controller.dart';
import '../../models/assignment_model.dart';
import '../widgets/headers.dart';

class AssignmentPage extends StatefulWidget {
  final bool graded;
  String? id;
  AssignmentPage({super.key, this.graded = false, this.id});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  AssignmentModel? assignment;

  Future<void> fetchAssignmentDetails() async {
    Log.i("fetching assignment details");
    try {
      await context
          .read<AssignmentController>()
          .getAssignmentDetails(widget.id != null ? widget.id! : "1")
          .then((value) {
        setState(() {
          assignment = context.read<AssignmentController>().getAssignmentObject;
        });
      });

      Log.d("assignment details: ${assignment!.title}");
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CourseHeader(
        title: "Assignment",
        subtitle: assignment != null ? assignment!.title : "Assignment 1",
        onMenuPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Column(
              children: <Widget>[
                AssignmentDetailCard(
                  dueDate:
                      assignment?.dueDate ?? DateTime(2021, 05, 04, 20, 20),
                  numResubmissions: 4,
                  resubmissionDueDate: DateTime(2023, 05, 04, 20, 20),
                  status: assignment != null ? assignment!.status : "<status!>",
                ),
                const VerticalSpacer(),
                widget.graded
                    ? const Subheading(text: "Feedback")
                    : const SizedBox(),
                widget.graded
                    ? Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "I think you did alright. But for next time I want work that will will you a nobel piece prize",
                          style: Styles.bodyMedium,
                        ),
                      )
                    : const SizedBox(),
                widget.graded ? const VerticalSpacer() : const SizedBox(),
                const Subheading(text: "Instructions"),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(16.0),
                  decoration: boxDecoration,
                  child: Text(
                    assignment != null
                        ? assignment!.description
                        : "This means description is not coming",
                    style: Styles.bodyMedium,
                  ),
                ),
                const VerticalSpacer(),
                const Subheading(text: "Files"),
                assignment?.files == null ? 
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "No files to download",
                    style: Styles.bodyMedium,
                  ),
                ) :
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please download the following files to complete the assignment.",
                    style: Styles.bodyMedium,
                  ),
                ),
                const VerticalSpacer(),
                if (assignment?.files != null && assignment!.files!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: assignment!.files
                        !.map((file) => InkWell(
                              onTap: () async {
                               
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.file_download),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Text(
                                        file.url,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                const VerticalSpacer(),
                const Subheading(text: "Submissions"),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please submit the final documents in PDF format.",
                    style: Styles.bodySmall,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Submissions(),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: !widget.graded
          ? Container(
              padding: const EdgeInsets.all(16),
              child: MainButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "Submit Assignment",
                color: Colors.green,
              ),
            )
          : const SizedBox(),
    );
  }
}
