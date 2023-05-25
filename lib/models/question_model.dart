import 'package:front_end/models/answer_model.dart';

class QuestionModel {
  String id;
  String questionDescription;
  List<AnswerModel> answers;
  String correctAnswer;
  int marks;

  QuestionModel({
    this.id = "<!id>",
    this.questionDescription = "<!questionDescription>",
    this.answers = const [],
    this.correctAnswer = "<!correctAnswer>",
    this.marks = -1,
  });

  QuestionModel copyWith({
    String? id,
    String? questionDescription,
    List<AnswerModel>? answers,
    String? correctAnswer,
    int? marks,
  }) =>
      QuestionModel(
        id: id ?? this.id,
        questionDescription: questionDescription ?? this.questionDescription,
        answers: answers ?? this.answers,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        marks: marks ?? this.marks,
      );

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json["_id"] ?? "<!id>",
        questionDescription:
            json["questionDescription"] ?? "<!questionDescription>",
        answers: json["answers"] == null
            ? []
            : List<AnswerModel>.from(
                json["answers"].map((x) => AnswerModel.fromJson(x))),
        correctAnswer: json["correctAnswer"] ?? "<!correctAnswer>",
        marks: json["marks"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "questionDescription": questionDescription,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "correctAnswer": correctAnswer,
        "marks": marks,
      };
}
