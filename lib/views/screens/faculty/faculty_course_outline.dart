import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/views/screens/faculty/test/textread.dart';
import 'package:front_end/views/widgets/bottom_popup.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:front_end/views/widgets/textfields.dart';
import 'package:provider/provider.dart';

class FacCourseOutlinePage extends StatefulWidget {
  final String courseOutline;

  const FacCourseOutlinePage({required this.courseOutline, Key? key})
      : super(key: key);

  @override
  State<FacCourseOutlinePage> createState() => _FacCourseOutlinePageState();
}

class _FacCourseOutlinePageState extends State<FacCourseOutlinePage> {
  TextEditingController controller = TextEditingController();
  String enteredText = "";
  bool isEditing = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    controller.text = widget.courseOutline;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Container(
          height: MediaQuery.of(context).size.height, // Set a fixed height
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Course Outline",
                            style: Styles.titleLarge,
                          ),
                          !isEditing
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isEditing = !isEditing;
                                    });
                                  },
                                )
                              : IconButton(
                                  icon: const Icon(
                                    Icons.info,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    markdown_helper(context);
                                  },
                                )
                        ],
                      ),
                      isEditing ? const VerticalSpacer(): const SizedBox(),
                      !isEditing
                          ? FormattedTextWidget(markdownText: controller.text)
                          : Column(
                              children: [
                                MainTextField(
                                  label: "Course Outline",
                                  minLines: 8,
                                  maxLines: 10,
                                  controller: controller,
                                  helperText:
                                      "Markdown formatting is supported",
                                  onChange: (value) {
                                    setState(() {
                                      enteredText = value;
                                    });
                                  },
                                ),
                                const VerticalSpacer(),
                                const Subheading(text: "Preview"),
                                FormattedTextWidget(
                                    markdownText: controller.text),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              !isEditing
                  ? const SizedBox()
                  : MainButton(
                      text: loading ? "Saving..." : "Save",
                      color: loading ? Colors.grey : Colors.green,
                      onPressed: () {
                        setState(() {
                          loading = true;
                          updateSyllabus(
                              controller.text != "" || controller.text != " "
                                  ? controller.text
                                  : widget.courseOutline);
                        });
                      },
                      child: loading
                          ? const CircularProgressIndicator(
                              strokeWidth: 5,
                            )
                          : null)
            ],
          ),
        ),
      ),
    );
  }

  void updateSyllabus(String text) async {
    // Update the course outline from class Controller
    await context.read<ClassController>().updateSyllabus(text).then((value) {
      if (value == true) {
        setState(
          () {
            loading = false;
            isEditing = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Course outline updated successfully'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        );
      } else {
        setState(() {
          loading = false;
          isEditing = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error updating course outline'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        });
      }
    });
  }
}
