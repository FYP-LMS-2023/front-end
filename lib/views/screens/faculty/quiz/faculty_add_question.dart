import 'package:flutter/material.dart';
import 'package:front_end/constants/box_decoration.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/constants/spacers.dart';
import 'package:front_end/controllers/quiz_controller.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/headers.dart';
import 'package:front_end/views/widgets/subheadings.dart';
import 'package:front_end/views/widgets/textfields.dart';
import 'package:provider/provider.dart';

class FacAddQuestionPage extends StatefulWidget {
  final String id;
  const FacAddQuestionPage({
    super.key,
    required this.id,
  });

  @override
  State<FacAddQuestionPage> createState() => _FacAddQuestionPageState();
}

class _FacAddQuestionPageState extends State<FacAddQuestionPage> {
  final _formKey = GlobalKey<FormState>();
  final List<Questions> questionObjects = [];
  final List<String> answers = [];
  TextEditingController questionController = TextEditingController();
  TextEditingController optionController = TextEditingController();

  Map<int, dynamic> answerIDs = {};
  Map<int, dynamic> questionIDs = {};

  void createQuestions() async {
    for (int i = 0; i < questionObjects.length; i++) {
      print(widget.id);
      final questionData = {
        "questionDescription": questionObjects[i].questionText,
        "marks": 1,
        "quizID": widget.id,
      };
      await context
          .read<QuizController>()
          .createQuestion(questionData)
          .then((value) async {
        if (mounted) {
          print('phhydd: ${value}');
          if (value != '1') {
            for (int j = 0; j < questionObjects[i].options!.length; j++) {
              final answerData = {
                "answerDescription": questionObjects[i].options![j],
                "isCorrect": true,
                "questionID": value,
              };
              await context
                  .read<QuizController>()
                  .createAnswer(answerData)
                  .then((value) {
                if (mounted) {
                  if (value == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Question added successfully"),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Question could not be added"),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
              });
            }
          }
          // questionIDs[i] = value;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CourseHeader(
        title: "Add Questions",
        subtitle: "Class",
        onMenuPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            children: [
              Subheading(text: "Add Question"),
              Container(
                padding: EdgeInsets.all(16),
                decoration: boxDecoration,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      MainTextField(
                        label: "Question",
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a question';
                          }
                          return null;
                        },
                        controller: questionController,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: answers.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.013);
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(left: 36),
                              child: Text(
                                '->  ${answers[index]}',
                                style: Styles.titleMedium,
                              ),
                            );
                          }),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Container(
                        padding: EdgeInsets.only(left: 36),
                        child: MainTextField(
                          label: "Option",
                          controller: optionController,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Container(
                        padding: EdgeInsets.only(left: 36),
                        child: MainButton(
                            text: "+ Add Option",
                            color: Colors.grey,
                            onPressed: () {
                              setState(() {
                                answers.add(optionController.text);
                                optionController.clear();
                              });
                            }),
                      ),
                      const VerticalSpacer(),
                      MainButton(
                        text: "Save Question",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            questionObjects.add(
                              Questions(
                                questionText: questionController.text,
                                options: List<String>.from(answers),
                              ),
                            );
                            questionController.clear();
                            setState(() {
                              answers.clear();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const VerticalSpacer(),
              const Subheading(text: "Preview"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: questionObjects.asMap().entries.map((entry) {
                  int questionIndex = entry.key;
                  Questions question = entry.value;
                  // String questionID =
                  //     quizList!.questions[questionIndex].id; //no understand
                  List<String> questionAnswers = question.options!;
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
                          'Q${questionIndex + 1}) ${question.questionText}',
                          style:
                              Styles.titleMedium.copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ...questionAnswers.asMap().entries.map((answerEntry) {
                        int answerIndex = answerEntry.key;
                        String answer = answerEntry.value;
                        String answerText = question.options![answerIndex];

                        return Row(
                          children: [
                            Radio(
                              fillColor:
                                  MaterialStateProperty.all(Colors.black),
                              value: answerText,
                              groupValue: answerIDs[questionIndex],
                              onChanged: (value) {
                                setState(() {
                                  answerIDs[questionIndex] = value!;
                                  questionIDs[questionIndex] =
                                      question.questionText;
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: MainButton(
          onPressed: () {
            createQuestions();
          },
          text: "Save",
          color: Colors.green,
        ),
      ),
    );
  }
}

class Questions {
  String questionText;
  // List<String> answers;
  List<String>? options;
  
  Questions({
    required this.questionText,
    this.options,
    // this.answers = const [],
  });

  void addOption(String option) {
    options!.add(option);
  }
}
