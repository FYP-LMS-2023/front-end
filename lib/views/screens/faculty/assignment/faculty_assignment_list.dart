import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/drop_shadow.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/assignment_controller.dart';
import 'package:front_end/models/assignment_model.dart';
import 'package:front_end/views/screens/faculty/assignment/faculty_add_assignment.dart';
import 'package:front_end/views/screens/faculty/assignment/faculty_assignment_page.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:provider/provider.dart';

class FacAssignmentListPage extends StatefulWidget {
  final String? id;
  final String? fullName;
  const FacAssignmentListPage({super.key, this.fullName, this.id});

  @override
  State<FacAssignmentListPage> createState() => _FacAssignmentListPageState();
}

class _FacAssignmentListPageState extends State<FacAssignmentListPage> {
  List<AssignmentModel>? assignments;
  bool loading = true;

  fetchAssignments() async {
    try {
      await context
          .read<AssignmentController>()
          .getAllAssignments(widget.id != null ? widget.id! : "1")
          .then(
        (value) {
          setState(() {
            loading = false;
            assignments = context.read<AssignmentController>().getAssignments;
          });
        },
      );
    } catch (e) {
      Log.e(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAssignments();
    Log.e('step 3: ${widget.id}');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return loading
        ? const Loading()
        : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Column(
                children: [
                  // buildStats(context),
                  // const VerticalSpacer(),
                  const Subheading(text: "Assignments"),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FacAssignmentAddPage(
                                classID: widget.id != null ? widget.id! : "1",
                              )));
                    },
                    child: Ink(
                      padding: const EdgeInsets.all(4.0),
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          Text(
                            "Add Assignment",
                            style: Styles.titleMedium
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpacer(),
                  assignments == null
                      ? Container(
                          height: size.height * 0.5,
                          child: Text(
                            "No assignments yet",
                            style: Styles.bodySmall.copyWith(
                              color: Color.fromARGB(255, 97, 65, 65),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: size.height * 0.02),
                          shrinkWrap: true,
                          // clipBehavior: Clip.antiAliasWithSaveLayer,
                          itemCount: assignments!.length,
                          itemBuilder: (context, index) {
                            AssignmentModel assignment = assignments != null
                                ? assignments![index]
                                : AssignmentModel();
                            return CourseOverviewCard(
                              type: "assignments",
                              title: assignment.title,
                              date: assignment.dueDate ?? DateTime.now(),
                              description: assignment.description,
                              status: assignment.status,
                              onClick: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return FacAssignmentPage(
                                      id: assignment.id,
                                    );
                                  },
                                ));
                              },
                            );
                          },
                        ),
                ],
              ),
            ),
          );
  }

  Row buildStats(context) {
    final size = MediaQuery.of(context).size;
    return Row(
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
              Text('${20}%',
                  style: Styles.headlineLarge.copyWith(color: Colors.white)),
              Text(
                "Current",
                style: Styles.labelLarge.copyWith(color: Colors.white),
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
              Text('${40}%', style: Styles.headlineLarge),
              Text(
                "Weightage",
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
              Text('${25}', style: Styles.headlineLarge),
              Text(
                "/${50} Points",
                style: Styles.labelLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
