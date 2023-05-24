import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/controllers/class_controller.dart';
import 'package:front_end/models/answer_model.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/models/question_model.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/loading.dart';
import 'package:provider/provider.dart';

import '../../controllers/quiz_controller.dart';
import '../../models/quiz_model.dart';

class QuizPage extends StatefulWidget {
  QuizPage({this.id, super.key});

  String? id;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int index = 0;
  bool loading = true;
  Map<int, dynamic> answerIDs = {};
  Map<int, dynamic> questionIDs = {};
  String quizID = "";
  QuizModel? quizList;
  ClassModel? classData;

  Future<void> fetchQuizList() async {
    await context
        .read<QuizController>()
        .getCurrentQuizzes(widget.id != null ? widget.id! : "1")
        .then((value) {
      setState(() {
        loading = false;
        quizList = context.read<QuizController>().getCurrentQuiz;
        classData = context.read<ClassController>().getMyClass;
      });
    });
  }

  @override
  void initState() {
    fetchQuizList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<QuestionModel> quizQuestions = [];
    if (!loading) {
      quizQuestions = quizList!.questions;
      quizID = quizList!.id;
    }

    return loading
        ? const Scaffold(body: Loading())
        : Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: MainButton(
                onPressed: () {
                  //quizList!.status == "Submitted";
                  formatResponse(answerIDs, questionIDs);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                text: "Submit Quiz",
                color: Colors.green,
              ),
            ),
            appBar: CourseHeader(
              onMenuPressed: () {},
              title: quizList!.title,
              subtitle:
                  "${classData!.course!.courseCode} - ${classData!.course!.courseName}",
              disableBack: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: quizQuestions.asMap().entries.map((entry) {
                    int questionIndex = entry.key;
                    QuestionModel question = entry.value;
                    String questionID =
                        quizList!.questions[questionIndex].id; //no understand
                    List<AnswerModel> questionAnswers =
                        quizList!.questions[questionIndex].answers;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Palette.kToDark[50],
                          ),
                          padding: const EdgeInsets.all(5),
                          width: double.infinity,
                          child: Text(
                            'Q${questionIndex + 1}) ${quizList!.questions[questionIndex].questionDescription}',
                            style: Styles.titleMedium
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ...questionAnswers.asMap().entries.map((answerEntry) {
                          int answerIndex = answerEntry.key;
                          AnswerModel answer = answerEntry.value;
                          String answerID = quizList!
                              .questions[questionIndex].answers[answerIndex].id;
                          String answerText = quizList!.questions[questionIndex]
                              .answers[answerIndex].answerDescription;

                          return Row(
                            children: [
                              Radio(
                                fillColor:
                                    MaterialStateProperty.all(Colors.black),
                                value: answerID,
                                groupValue: answerIDs[questionIndex],
                                onChanged: (value) {
                                  setState(() {
                                    answerIDs[questionIndex] = value!;
                                    questionIDs[questionIndex] = questionID;
                                  });
                                },
                              ),
                              Text(answerText),
                            ],
                          );
                        }).toList(),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          );
  }

  void formatResponse(
      Map<int, dynamic> answerIDs, Map<int, dynamic> questionIDs) {
    List<Map<String, dynamic>> submissions = [];
    Map<String, dynamic> responseEntry = {};
    for (int i = 0; i < answerIDs.length; i++) {
      responseEntry["question"] = questionIDs[i];
      responseEntry["answer"] = answerIDs[i];
      submissions.add(responseEntry);
    }

    Log.i(submissions);
    Log.i('ye le bhai quiz ID: $quizID');

    // Map<String, dynamic> response = {
    //   "submittedFor": quizID,
    //   "submission": submissions,
    // };

    Map<String, dynamic> response = {};
    response["submittedFor"] = quizID;
    response["submission"] = submissions;

    Log.i(response);
    context.read<QuizController>().submitQuiz(response);
    Log.w(response);
  }
}
