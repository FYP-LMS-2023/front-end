import 'package:front_end/models/answer_model.dart';
import 'package:front_end/models/question_model.dart';
import 'package:front_end/models/quiz_model.dart';
import 'package:front_end/models/user_model.dart';

class QuizSubmissionModel {
  String id;
  UserModel? studentId;
  int marksReceived;
  QuizModel? submittedFor;
  DateTime? submissionDate;
  List<Submission> submission;

  QuizSubmissionModel({
    this.id = "<!id>",
    this.studentId,
    this.marksReceived = -1,
    this.submittedFor,
    this.submissionDate,
    this.submission = const [],
  });

  QuizSubmissionModel copyWith({
    String? id,
    UserModel? studentId,
    int? marksReceived,
    QuizModel? submittedFor,
    DateTime? submissionDate,
    List<Submission>? submission,
  }) =>
      QuizSubmissionModel(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId ?? UserModel(),
        marksReceived: marksReceived ?? this.marksReceived,
        submittedFor: submittedFor ?? this.submittedFor ?? QuizModel(),
        submissionDate: submissionDate ??
            this.submissionDate ??
            DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        submission: submission ?? this.submission,
      );

  factory QuizSubmissionModel.fromJson(Map<String, dynamic> json) =>
      QuizSubmissionModel(
        id: json["_id"] ?? "<!id>",
        studentId: json["studentID"] != null
            ? UserModel.fromJson(json["studentID"])
            : UserModel(),
        marksReceived: json["marksReceived"] ?? -1,
        submittedFor: json["submittedFor"] != null
            ? QuizModel.fromJson(json["submittedFor"])
            : QuizModel(),
        submissionDate: json["submissionDate"] != null
            ? DateTime.parse(json["submissionDate"])
            : DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        submission: json["submission"] != null
            ? List<Submission>.from(
                json["submission"].map((x) => Submission.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "studentID": studentId != null ? studentId!.toJson() : null,
        "marksReceived": marksReceived,
        "submittedFor": submittedFor != null ? submittedFor!.toJson() : null,
        "submissionDate":
            submissionDate != null ? submissionDate!.toIso8601String() : null,
        "submission": List<dynamic>.from(submission.map((x) => x.toJson())),
      };
}

class Submission {
  String id;
  QuestionModel? question;
  AnswerModel? answer;

  Submission({
    this.id = "<!id>",
    this.question,
    this.answer,
  });

  Submission copyWith({
    String? id,
    QuestionModel? question,
    AnswerModel? answer,
  }) =>
      Submission(
        id: id ?? this.id,
        question: question ?? this.question ?? QuestionModel(),
        answer: answer ?? this.answer ?? AnswerModel(),
      );

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
        id: json["_id"] ?? "<!id>",
        question: json["question"] != null
            ? QuestionModel.fromJson(json["question"])
            : QuestionModel(),
        answer: json["answer"] != null
            ? AnswerModel.fromJson(json["answer"])
            : AnswerModel(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "question": question != null ? question!.toJson() : null,
        "answer": answer != null ? answer!.toJson() : null,
      };
}
