import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/assignment_controller.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/textfields.dart';
import 'package:provider/provider.dart';

class FacGradeAssignmentPage extends StatefulWidget {
  final String? id;
  const FacGradeAssignmentPage({super.key, this.id});

  @override
  State<FacGradeAssignmentPage> createState() => _FacGradeAssignmentPageState();
}

class _FacGradeAssignmentPageState extends State<FacGradeAssignmentPage> {
  bool loading = false;
  TextEditingController marksController = TextEditingController();
  TextEditingController returnDescController = TextEditingController();

  void gradeAssignment(int marks, String returnDesc) async {
    setState(() {
      loading = true;
    });
    context
        .read<AssignmentController>()
        .gradeAssignment(
          widget.id != null ? widget.id! : "1",
          marks,
          returnDesc,
        )
        .then(
      (value) {
        if (value == true) {
          setState(() {
            loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Assignment graded successfully'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else if (value == false) {
          setState(() {
            loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Assignment grading failed'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor:  backgroundColor,
            appBar: CourseHeader(
              onMenuPressed: () {},
              title: "Grade Assignments",
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        MainTextField(
                          label: "Marks",
                          controller: marksController,
                          validator: (value) {
                            //check to see if value is anything other than a number
                            if (value != null && !isNumeric(value)) {
                              return 'Please enter a valid number';
                            }
                            if (value == null || value.isEmpty) {
                              return 'Please enter marks';
                            }
                            return null;
                          },
                        ),
                        const VerticalSpacer(),
                        MainTextField(
                            label: "Feedback",
                            controller: returnDescController,
                            maxLines: 10,
                            minLines: 6,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter feedback';
                              }
                              return null;
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(16.0),
              child: MainButton(
                onPressed: () {
                  gradeAssignment(
                    int.parse(marksController.text),
                    returnDescController.text,
                  );
                },
                text: "Grade Assignment",
                color: Colors.green,
              ),
            ),
          );
  }

  bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}
