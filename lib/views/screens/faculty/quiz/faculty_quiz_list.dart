import 'package:flutter/material.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/controllers/quiz_controller.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/models/quiz_model.dart';
import 'package:front_end/views/screens/faculty/quiz/faculty_add_question.dart';
import 'package:front_end/views/screens/faculty/quiz/faculty_add_quiz.dart';
import 'package:front_end/views/widgets/cards.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:provider/provider.dart';

class FacQuizListPage extends StatefulWidget {
  final String? id;
  const FacQuizListPage({super.key, this.id});

  @override
  State<FacQuizListPage> createState() => _FacQuizListPageState();
}

class _FacQuizListPageState extends State<FacQuizListPage> {
  bool loading = true;
  List<QuizModel>? quizzes;
  ClassModel? classData;

  Future<void> fetchQuizDetails() async {
    try {
      await context
          .read<QuizController>()
          .getAllQuizzes(widget.id != null ? widget.id! : "1")
          .then((value) {
        setState(() {
          loading = false;
          quizzes = context.read<QuizController>().getQuizzes;
          classData = context.read<ClassController>().getMyClass;
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
    final size = MediaQuery.of(context).size;
    return loading
        ? const Loading()
        : SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  children: <Widget>[
                    const Subheading(text: "Quizzes"),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => StartPage(
                                  id: widget.id != null ? widget.id! : "1",
                                )));
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return FacAddQuestionPage(
                        //         id: "646ed623a1b7d4b9d19a4839",
                        //       );
                        //     },
                        //   ),
                        // );
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return FacAddResourcePage(
                        //         classID: widget.id != null ? widget.id! : "1",
                        //       );
                        //     },
                        //   ),
                        // );
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
                              "Add Quiz",
                              style: Styles.titleMedium
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const VerticalSpacer(),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      clipBehavior: Clip.none,
                      itemCount: quizzes!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CourseOverviewCard(
                              type: "quiz",
                              title: quizzes != null
                                  ? quizzes![index].title
                                  : "Untitled",
                              date: quizzes![index].dueDate ?? DateTime.now(),
                              marks:
                                  quizzes != null ? quizzes![index].marks : 0,
                              status: quizzes![index].status,
                              onClick: () {
                                // if (quizzes![index].status == "open" ||
                                //     time_left(quizzes![index].dueDate) !=
                                //         "Expired") {
                                //   Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           QuizPageStart(id: quizzes![index].id),
                                //     ),
                                //   );
                                // }
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                          ],
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
