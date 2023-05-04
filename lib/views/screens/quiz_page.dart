import 'package:flutter/material.dart';
import 'package:front_end/constants/colors.dart';
import 'package:front_end/constants/fonts.dart';
import 'package:front_end/views/widgets/buttons.dart';
import 'package:front_end/views/widgets/headers.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int index = 0;
  // Map<int, String> answers = {}; // store the selected answers for each question
  Map<int, dynamic> answerIDs = {};
  Map<int, dynamic> questionIDs = {};
  String quizID = "";
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> quizDetails = {
      "_id": "6448f6e9ecb0b17dde7b9b78",
      "title": "Quiz 2",
      "description": "Quiz for testing purposes",
      "dueDate": "1970-01-20T11:20:32.705Z",
      "startDate": "1970-01-20T11:20:29.105Z",
      "classId": "643bdd201d72385b7e29e2c2",
      "status": "closed",
      "questions": [
        {
          "_id": "6448f743ecb0b17dde7b9b7c",
          "questionDescription": "What is this test?",
          "answers": [
            {
              "_id": "6448f772ecb0b17dde7b9b81",
              "answerDescription": "This the correct answer for quiz2"
            },
            {
              "_id": "6448f790ecb0b17dde7b9b86",
              "answerDescription": "This incorrect answer 1 for quiz2"
            },
            {
              "_id": "6448f7a4ecb0b17dde7b9b8b",
              "answerDescription": "This incorrect answer 2 for quiz2"
            },
            {
              "_id": "6448f7b8ecb0b17dde7b9b90",
              "answerDescription": "This incorrect answer 3 for quiz2"
            }
          ],
          "marks": 10
        },
        {
          "_id": "6448f7dfecb0b17dde7b9b95",
          "questionDescription": "What is this test 2?",
          "answers": [
            {
              "_id": "6448f815ecb0b17dde7b9b9a",
              "answerDescription": "This incorrect answer 4 for quiz2"
            },
            {
              "_id": "6448f831ecb0b17dde7b9b9f",
              "answerDescription": "This incorrect answer 5 for quiz2"
            },
            {
              "_id": "6448f839ecb0b17dde7b9ba4",
              "answerDescription": "This incorrect answer 6 for quiz2"
            },
            {
              "_id": "6448f84cecb0b17dde7b9ba9",
              "answerDescription": "This correct answer 2 for quiz2"
            }
          ],
          "marks": 3
        },
        {
          "_id": "6448f8b9698df76ff2679f27",
          "questionDescription": "What is this test 3?",
          "answers": [
            {
              "_id": "6448f8f1698df76ff2679f2c",
              "answerDescription": "This correct answer 3 for quiz2"
            },
            {
              "_id": "6448f900698df76ff2679f31",
              "answerDescription": "This incorrect answer 3 for quiz2"
            },
            {
              "_id": "6448f908698df76ff2679f36",
              "answerDescription": "This incorrect answer 4 for quiz2"
            },
            {
              "_id": "6448f90e698df76ff2679f3b",
              "answerDescription": "This incorrect answer 9 for quiz2"
            }
          ],
          "marks": 7
        }
      ],
      "marks": 20,
      "uploadDate": "2023-04-26T10:03:21.406Z",
      "__v": 3
    };
    List<Map<String, dynamic>> quizQuestions = quizDetails["questions"];
    quizID = quizDetails["_id"];

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: MainButton(
          onPressed: () {
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
        title: "Quiz Number 1",
        subtitle: "CS150 - Final Year Project",
        disableBack: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: quizQuestions.asMap().entries.map((entry) {
              int questionIndex = entry.key;
              Map<String, dynamic> question = entry.value;
              String questionID = question['_id'];
              List<Map<String, dynamic>> questionAnswers = question['answers'];
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
                      'Q${1}) ${question["questionDescription"]}',
                      style: Styles.titleMedium.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ...questionAnswers.asMap().entries.map((answerEntry) {
                    int answerIndex = answerEntry.key;
                    Map<String, dynamic> answer = answerEntry.value;
                    String answerID = answer['_id'];
                    String answerText = answer['answerDescription'];

                    return Row(
                      children: [
                        Radio(
                          fillColor: MaterialStateProperty.all(Colors.black),
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
    for (int i = 0; i < answerIDs.length; i++) {
      Map<String, dynamic> responseEntry = {
        "question": questionIDs[i],
        "answer": answerIDs[i],
      };
      submissions.add(responseEntry);
    }

    Map<String, dynamic> response = {
      "submittedFor": quizID,
      "submissions": submissions,
    };
    print(response);
  }
}
