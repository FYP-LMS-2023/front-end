import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/controllers/quiz_controller.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/models/quiz_model.dart';
import 'package:front_end/views/screens/quiz_page.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:provider/provider.dart';

class QuizPageStart extends StatefulWidget {
  String? id;

  QuizPageStart({Key? key, this.id}) : super(key: key);

  @override
  State<QuizPageStart> createState() => _QuizPageStartState();
}

class _QuizPageStartState extends State<QuizPageStart> {
  bool loading = true;
  QuizModel? quizzes;
  ClassModel? classData;

  Future<void> fetchQuizDetails() async {
    Log.i("fetching quiz details");
    try {
      await context
          .read<QuizController>()
          .getCurrentQuizzes(widget.id != null ? widget.id! : "1")
          .then((value) {
        setState(() {
          quizzes = context.read<QuizController>().getCurrentQuiz;
          classData = context.read<ClassController>().getMyClass;
          loading = false;
        });
      });
    } catch (e) {
      Log.e("$e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuizDetails();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(body: Loading())
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: CourseHeader(
              title:
                  quizzes?.title ?? "", //quizzes == null ? quizzes!.title : "",
              subtitle:
                  "${classData!.course!.courseCode} - ${classData!.course!.courseName}",
              onMenuPressed: () {},
            ),
            body: Center(
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Instructions",
                            style: Styles.headlineSmall,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(quizzes?.description ??
                              ""), //quizzes == null ? quizzes!.description : ""
                          const VerticalSpacer(),
                          Text(
                            "We will add some basic instructions here that will be followed for all tests",
                            style: Styles.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: MainButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QuizPage(id: widget.id != null ? widget.id! : "1"),
                    ),
                  );
                },
                text: "Start Quiz",
                color: Palette.kToDark[50],
              ),
            ),
          );
  }
}
