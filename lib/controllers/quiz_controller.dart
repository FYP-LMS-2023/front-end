import 'package:flutter/material.dart';
import 'package:front_end/entities/quiz_entity.dart';
import 'package:front_end/models/mock_data.dart';
import 'package:front_end/models/quiz_model.dart';

class QuizProvider extends ChangeNotifier {
  List<QuizEntity> list = [];

  List<QuizEntity> get getQuizes => list;

  void loadQuizzes() {
    list = [];

    QuizModel quizModel = QuizModel.fromJson(quizJSON);

    QuizEntity quiz = QuizEntity(
      title: quizModel.title,
      description: quizModel.description,
      uploadDate: quizModel.uploadDate,
      dueDate: quizModel.dueDate,
      startDate: quizModel.startDate,
      status: quizModel.status,
      resubmissionsAllowed: quizModel.resubmissionsAllowed,
      resubmissionDeadline: quizModel.resubmissionDeadline,
      marks: quizModel.marks,
      attachments: quizModel.attachments,
      submissions: quizModel.submissions,
      questions: quizModel.questions,
    );
    list.add(quiz);
  }

  @override
  notifyListeners();
}
