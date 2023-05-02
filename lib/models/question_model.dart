import 'package:front_end/models/answer_model.dart';

class QuestionModel {
  String id;
  String questionDescription;
  List<AnswerModel> answers;
  int marks;

  QuestionModel({
    this.id = "<!id>",
    this.questionDescription = "<!questionDescription>",
    this.answers = const [],
    this.marks = -1,
  });

  QuestionModel copyWith({
    String? id,
    String? questionDescription,
    List<AnswerModel>? answers,
    AnswerModel? correctAnswer,
    int? marks,
  }) =>
      QuestionModel(
        id: id ?? this.id,
        questionDescription: questionDescription ?? this.questionDescription,
        answers: answers ?? this.answers,
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
        marks: json["marks"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "questionDescription": questionDescription,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "marks": marks,
      };
}
