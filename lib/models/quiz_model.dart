import 'package:front_end/models/class_model.dart';
import 'package:front_end/models/question_model.dart';
import 'package:front_end/models/quiz_submission_model.dart';

class QuizModel {
  String id;
  String title;
  String description;
  DateTime? uploadDate;
  DateTime? dueDate;
  DateTime? startDate;
  ClassModel? classId;
  String status;
  List<QuizSubmissionModel> submissions;
  List<QuestionModel> questions;
  int marks;

  QuizModel({
    this.id = "<!id>",
    this.title = "<!title>",
    this.description = "<!description>",
    this.uploadDate,
    this.dueDate,
    this.startDate,
    this.classId,
    this.status = "<!status>",
    this.submissions = const [],
    this.questions = const [],
    this.marks = -1,
  });

  QuizModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? uploadDate,
    DateTime? dueDate,
    DateTime? startDate,
    ClassModel? classId,
    String? status,
    List<QuizSubmissionModel>? submissions,
    List<QuestionModel>? questions,
    int? marks,
  }) =>
      QuizModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        uploadDate: uploadDate ??
            this.uploadDate ??
            DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        dueDate: dueDate ??
            this.dueDate ??
            DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        startDate: startDate ??
            this.startDate ??
            DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        classId: classId ?? this.classId ?? ClassModel(),
        status: status ?? this.status,
        submissions: submissions ?? this.submissions,
        questions: questions ?? this.questions,
        marks: marks ?? this.marks,
      );

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        id: json["_id"] ?? "<!id>",
        title: json["title"] ?? "<!title>",
        description: json["description"] ?? "<!description>",
        uploadDate: json["uploadDate"] == null
            ? DateTime(2000, 2, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["uploadDate"]),
        dueDate: json["dueDate"] == null
            ? DateTime(2000, 2, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["dueDate"]),
        startDate: json["startDate"] == null
            ? DateTime(2000, 2, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["startDate"]),
        // classId: ClassModel.fromJson(json["classId"]),
        classId: json["classId"] == null
            ? ClassModel()
            : ClassModel.fromJson(json["classId"]),
        status: json["status"],
        submissions: json["submissions"] == null
            ? []
            : List<QuizSubmissionModel>.from(json["submissions"]
                .map((x) => QuizSubmissionModel.fromJson(x))),
        questions: json["questions"] == null
            ? []
            : List<QuestionModel>.from(
                json["questions"].map((x) => QuestionModel.fromJson(x))),
        marks: json["marks"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "uploadDate": uploadDate == null ? null : uploadDate!.toIso8601String(),
        "dueDate": dueDate == null ? null : dueDate!.toIso8601String(),
        "startDate": startDate == null ? null : startDate!.toIso8601String(),
        "classId": classId == null ? null : classId!.toJson(),
        "status": status,
        "submissions": List<dynamic>.from(submissions.map((x) => x.toJson())),
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "marks": marks,
      };
}
