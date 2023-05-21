import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/views/screens/faculty/test/textread.dart';
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

  var markdownFormattingGuide = 
  "# Markdown Formatting Guide\n\n"
      "## Headers\n"
      "To create a header, add one to six # symbols before your heading text. The number of # you use will determine the size of the heading.\n\n"
      "Write this: \n"
      "```\n"
      "# The largest heading\n"
      "## The second largest heading\n"
      "###### The smallest heading\n"
      "```\n\n"
      "It will appear as: \n"
      "# The largest heading\n"
      "## The second largest heading\n"
      "###### The smallest heading\n\n"
      "---\n\n"
      "## Emphasis\n"
      "To emphasize text with bold, add two asterisks or underscores before and after a word or phrase. To emphasize text with italics, add one asterisk or underscore before and after a word or phrase.\n\n"
      "Write this: \n"
      "```\n"
      "**This is bold text**\n\n"
      "__This is bold text__\n\n"
      "*This text is italicized*\n\n"
      "_This text is italicized_\n\n"
      "```\n\n"
      "It will appear as: \n\n"
      "**This is bold text**\n\n"
      "__This is bold text__\n\n"
      "*This text is italicized*\n\n"
      "_This text is italicized_\n\n"
      "---\n\n"
      "## Lists\n"
      "You can organize items into ordered and unordered lists.\n\n"
      "### Unordered\n"
      "To create an unordered list, add dashes (-), asterisks (*), or plus signs (+) and a space before the text. Indent one or more items to create a nested list.\n\n"
      "Write this: \n"
      "```\n"
      "- George Washington\n"
      "- John Adams\n"
      "- Thomas Jefferson\n"
      "```\n\n"
      "It will appear as: \n"
      "- George Washington\n"
      "- John Adams\n"
      "- Thomas Jefferson\n\n"
      "### Ordered\n"
      "To create an ordered list, add numbers and a period before each line item. Indent one or more items to create a nested list.\n\n"
      "Write this: \n"
      "```\n"
      "1. James Madison\n"
      "2. James Monroe\n"
      "3. John Quincy Adams\n"
      "```\n\n"
      "It will appear as: \n"
      "1. James Madison\n"
      "2. James Monroe\n"
      "3. John Quincy Adams\n\n"
      "---\n\n"
      "## Code Blocks\n"
      "To create a code block, indent your text by four spaces or use triple backticks (`) before and after the code.\n\n"
      "Write this: \n"
      "```\n"
      "    print('Hello, World!');\n"
      "```\n\n"
      "It will appear as: \n"
      "```\n"
      "print('Hello, World!');\n"
      "```\n\n"
      "---\n\n"
      "## Blockquotes\n"
      "To create a blockquote, use the greater than (>) symbol before the text.\n\n"
      "Write this: \n"
      "```\n"
      "> This is a blockquote.\n"
      "```\n\n"
      "It will appear as: \n"
      "> This is a blockquote.\n\n";
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
                        children: [
                          Text(
                            "Course Outline",
                            style: Styles.titleLarge,
                          ),
                          IconButton(
                            icon: Icon(Icons.info),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                elevation: 2,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.48,
                                          child: Markdown(
                                            data: markdownFormattingGuide,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        ],
                      ),
                      const VerticalSpacer(),
                      !isEditing
                          ? FormattedTextWidget(markdownText: controller.text)
                          : Column(
                              children: [
                                MainTextField(
                                  label: "Course Outline",
                                  maxLines: null,
                                  controller: controller,
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
                  ? MainButton(
                      text: "Edit",
                      onPressed: () {
                        setState(() {
                          isEditing = !isEditing;
                        });
                      })
                  : MainButton(
                      text: loading ? "Saving..." : "Save",
                      color: Colors.green,
                      onPressed: () {
                        setState(() {
                          loading = true;
                          updateSyllabus(
                              controller.text != "" || controller.text != " "
                                  ? controller.text
                                  : widget.courseOutline);
                        });
                      })
            ],
          ),
        ),
      ),
    );
  }

  void updateSyllabus(String text) async {
    // Update the course outline from class Controller
    await context.read<ClassController>().updateSyllabus(text).then((value) {
      setState(() {
        loading = false;
        isEditing = false;
      });
    });
  }
}
