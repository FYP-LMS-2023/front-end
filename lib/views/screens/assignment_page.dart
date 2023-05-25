import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:front_end/views/widgets/submissions.dart';
import 'package:front_end/views/widgets/textfields.dart';
import 'package:provider/provider.dart';
import '../../constants/log.dart';
import '../../controllers/assignment_controller.dart';
import '../../models/assignment_model.dart';
import '../widgets/headers.dart';
import 'package:url_launcher/url_launcher.dart';

class AssignmentPage extends StatefulWidget {
  final bool graded;

  String? id;
  AssignmentPage({super.key, this.graded = false, this.id});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  List<File>? filesToUpload;
  AssignmentModel? assignment;
  final submissionDescriptionController = TextEditingController();
  bool loading = false;

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
      Log.d("Submitted Assignment: ${assignment!.isSubmitted}");
    } catch (e) {
      Log.e("error araha fetch assignment details me $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAssignmentDetails();
    filesToUpload = [];
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
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
      body: assignment == null || loading
          ? const Loading()
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    children: <Widget>[
                        assignment!.mySubmission!.returned ?? false
                          ? Container(
                              padding: const EdgeInsets.all(4.0),
                              height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                // border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                                color: assignment!.mySubmission!.returned!
                                    ? assignment!.mySubmission!.marksReceived! >
                                            50
                                        ? Colors.green
                                        : Colors.red
                                    : Colors.grey,
                              ),
                              child: Text(
                                assignment!.mySubmission!.returned!
                                    ? "Marks: ${assignment!.mySubmission!.marksReceived!} out of ${assignment!.marks}"
                                    : "Not Returned",
                                style: Styles.bodySmall
                                    .copyWith(color: Colors.white),
                              ),
                            )
                          : const SizedBox(),
                      AssignmentDetailCard(
                        dueDate: assignment?.dueDate ??
                            DateTime(2021, 05, 04, 20, 20),
                        numResubmissions: assignment!.resubmissionsAllowed,
                        resubmissionDueDate: DateTime.parse(
                            assignment!.resubmissionDeadline.toString()),
                        status: assignment != null
                            ? assignment!.status
                            : "<status!>",
                        marks: assignment != null ? assignment!.marks : 0,
                        isHidden: assignment!.mySubmission!.returned ?? false,
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
                      assignment?.files == null || assignment!.files!.isEmpty
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
                              _launchInBrowser(
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
                                      child: createIcon(assignment!
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
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const VerticalSpacer(),
                      const Subheading(text: "Submission"),
                      assignment!.isSubmitted
                          ? (assignment!.mySubmission!.submissionDescription ==
                                  null
                              ? const CircularProgressIndicator()
                              : Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Submitted Description",
                                        style: Styles.bodyMedium,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: boxDecoration,
                                      child: Text(
                                        assignment != null
                                            ? assignment!.mySubmission!
                                                .submissionDescription!
                                            : "This means description is not coming",
                                        style: Styles.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ))
                          : MainTextField(
                              label: "Submission Description",
                              controller: submissionDescriptionController,
                              maxLines: 6,
                              minLines: 6,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Please enter the submission description';
                                }
                                return null;
                              },
                            ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      assignment!.isSubmitted
                          ? const SizedBox()
                          : Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Attach files (optional)",
                                style: Styles.bodySmall,
                              ),
                            ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width,
                      //   child: const Submissions(),
                      // )
                      assignment!.isSubmitted
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Submitted Files",
                                style: Styles.bodyMedium,
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      if (assignment!.isSubmitted)
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: assignment != null
                              ? assignment!.mySubmission!.files!.length
                              : 0,
                          separatorBuilder: (context, index) => SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                _launchInBrowser(Uri.parse(assignment!
                                    .mySubmission!.files![index].url));
                              },
                              child: Ink(
                                decoration: boxDecoration,
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.13,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.13,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: createIcon(assignment!
                                            .mySubmission!.files![index].url
                                            .split("-")
                                            .last
                                            .split(".")[1]),
                                      ),
                                      const HorizontalSpacer(),
                                      Expanded(
                                          child: Text(
                                        assignment!
                                            .mySubmission!.files![index].url
                                            .split("/")[8]
                                            .split("-")[1]
                                            .replaceAll('%20', ' '),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: filesToUpload!.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02);
                        },
                        itemBuilder: (context, index) {
                          return Ink(
                            decoration: boxDecoration,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  createIcon2(filesToUpload![index]
                                      .path
                                      .split('.')
                                      .last),
                                  const HorizontalSpacer(),
                                  Expanded(
                                    child: Text(
                                      filesToUpload![index]
                                          .path
                                          .split('/')
                                          .last,
                                      style: Styles.bodyMedium,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        filesToUpload!.removeAt(index);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      assignment!.isSubmitted
                          ? const SizedBox()
                          : MainButton(
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker
                                    .platform
                                    .pickFiles(allowMultiple: true);
                                if (result != null) {
                                  setState(() {
                                    filesToUpload!.addAll(result.paths
                                        .map((path) => File(path!))
                                        .toList());
                                  });
                                }
                              },
                              text: "Upload File",
                              color: Colors.black,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: assignment != null && !widget.graded
          ? Container(
              padding: const EdgeInsets.all(16),
              child: assignment!.isSubmitted
                  ? assignment!.dueDate!.isAfter(DateTime.now()) && !assignment!.mySubmission!.returned! ? 
                  MainButton(text: "Resubmit Assignment", onPressed: () {},color: Colors.blue,) : 
                  const MainButton(text: "Submit Assignment", onPressed: null)
                  : MainButton(
                      onPressed: () async {
                        if (submissionDescriptionController.text
                            .trim()
                            .isNotEmpty) {
                          setState(() {
                            loading = true;
                          });
                          final assignmentData = {
                            "submissionDescription":
                                submissionDescriptionController.text.trim(),
                          };

                          await context
                              .read<AssignmentController>()
                              .submitAsssignment(
                                  assignment!.id, assignmentData, filesToUpload)
                              .then((value) {
                            if (value == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Assignment submitted successfully'),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Error submitting assignment'),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              setState(() {
                                loading = false;
                              });
                            }
                          });
                        }
                        Navigator.pop(context);
                      },
                      text: "Submit Assignment",
                      color: Colors.green,
                    ),
            )
          : const SizedBox(),
    );
  }

  Icon createIcon2(String ext) {
    // print(ext);
    if (ext == "pdf") {
      return const Icon(Icons.picture_as_pdf_rounded, color: Colors.black);
    } else if (ext == "jpeg") {
      return const Icon(Icons.image, color: Colors.white);
    } else if (ext == "jpg") {
      return const Icon(Icons.image, color: Colors.white);
    } else if (ext == "png") {
      return const Icon(Icons.image, color: Colors.black);
    } else if (ext == "mp4") {
      return const Icon(Icons.video_library, color: Colors.black);
    } else if (ext == "mp3") {
      return const Icon(Icons.audio_file, color: Colors.black);
    } else if (ext == "txt") {
      return const Icon(Icons.text_snippet_rounded, color: Colors.black);
    } else if (ext == "docx") {
      return const Icon(Icons.edit_document, color: Colors.black);
    }
    return const Icon(Icons.file_copy_rounded, color: Colors.black);
  }

  Icon createIcon(String ext) {
    // print(ext);
    if (ext == "pdf") {
      return const Icon(
        Icons.picture_as_pdf_rounded,
        color: Colors.white,
      );
    } else if (ext == "jpeg") {
      return const Icon(Icons.image, color: Colors.white);
    } else if (ext == "jpg") {
      return const Icon(Icons.image, color: Colors.white);
    } else if (ext == "png") {
      return const Icon(Icons.image, color: Colors.white);
    } else if (ext == "mp4") {
      return const Icon(Icons.video_library, color: Colors.white);
    } else if (ext == "mp3") {
      return const Icon(Icons.audio_file, color: Colors.white);
    } else if (ext == "txt") {
      return const Icon(Icons.text_snippet_rounded, color: Colors.white);
    } else if (ext == "docx") {
      return const Icon(Icons.edit_document, color: Colors.white);
    }
    return const Icon(
      Icons.file_copy_rounded,
      color: Colors.white,
    );
  }
}
