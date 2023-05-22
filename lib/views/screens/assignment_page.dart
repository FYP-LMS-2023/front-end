import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:front_end/views/widgets/submissions.dart';
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
      body: assignment == null ?
      const Loading() 
      : SingleChildScrollView(
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
              ListView.separated(
                shrinkWrap: true,
                itemCount: assignment != null ? assignment!.files!.length : 0,
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
                              width: MediaQuery.of(context).size.width * 0.13,
                              height: MediaQuery.of(context).size.width * 0.13,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: createIcon(assignment!.files![index].url
                                  .split("-")[1]
                                  .split(".")[1]),
                            ),
                            const HorizontalSpacer(),
                            Expanded(
                              child: 
                                Text(assignment!.files![index].url
                                    .split("/")[8]
                                    .split("-")[1].replaceAll('%20', ' '),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
                // if (assignment?.files != null && assignment!.files!.isNotEmpty)
                //   Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: assignment!.files
                //         !.map((file) => InkWell(
                //               onTap: () async {
                               
                //               },
                //               child: Container(
                //                 margin: const EdgeInsets.only(bottom: 8.0),
                //                 child: Row(
                //                   children: [
                //                     Icon(Icons.file_download),
                //                     const SizedBox(width: 8.0),
                //                     Expanded(
                //                       child: Text(
                //                         file.url,
                //                         overflow: TextOverflow.ellipsis,
                //                         maxLines: 4,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ))
                //         .toList(),
                //   ),
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
  
  Icon createIcon(String ext) {
    // print(ext);
    if (ext == "pdf") {
      return const Icon(
        Icons.picture_as_pdf_rounded,
        color: Colors.white,
      );
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
