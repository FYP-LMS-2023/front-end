import 'package:flutter/material.dart';
import 'package:front_end/controllers/assignment_controller.dart';
import 'package:front_end/models/assignment_submission_model.dart';
import 'package:front_end/views/screens/faculty/assignment/faculty_view_submission.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:provider/provider.dart';

class FacSubmissionsListPage extends StatefulWidget {
  final String? id;
  final int? totalMarks;
  const FacSubmissionsListPage({super.key, this.id, this.totalMarks});

  @override
  State<FacSubmissionsListPage> createState() => _FacSubmissionsListPageState();
}

class _FacSubmissionsListPageState extends State<FacSubmissionsListPage> {
  List<AssignmentSubmissionModel>? submissions;
  bool loading = true;

  void getSubmissionList() async {
    await context
        .read<AssignmentController>()
        .getAllSubmissions(widget.id != null ? widget.id! : "1")
        .then(
      (value) {
        setState(() {
          loading = false;
          submissions = context.read<AssignmentController>().getSubmissions;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getSubmissionList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return loading
        ? const Scaffold(body: Loading())
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: CourseHeader(
              title: "Submissions",
              onMenuPressed: () {},
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.05),
                child: Column(
                  children: [
                    const Subheading(text: "Submissions"),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: size.height * 0.02),
                      shrinkWrap: true,
                      itemCount: submissions!.length,
                      itemBuilder: (context, index) {
                        AssignmentSubmissionModel sub = submissions != null
                            ? submissions![index]
                            : AssignmentSubmissionModel();
                        return SubmissionCard(
                          fullName: sub.studentId!.fullName,
                          submitDate: sub.uploadDate,
                          description: sub.submissionDescription != null
                              ? sub.submissionDescription!
                              : "No description",
                          erp: sub.studentId!.erp,
                          returned: sub.returned!,
                          onClick: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FacViewSubmissionPage(
                                  submission: sub,
                                ),
                              ),
                            );
                          },
                          marks: sub.marksReceived,
                          totalMarks: widget.totalMarks,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
