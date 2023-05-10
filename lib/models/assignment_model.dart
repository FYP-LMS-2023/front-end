import 'package:front_end/models/class_model.dart';
import 'package:front_end/models/submission_model.dart';

class AssignmentModel {
  String id;
  DateTime? uploadDate;
  DateTime? dueDate;
  String title;
  ClassModel? classId;
  int resubmissionsAllowed;
  String status;
  DateTime? resubmissionDeadline;
  String description;
  String filename;
  String filePath;
  int fileSize;
  String fileType;
  List<SubmissionModel> submissions;
  int marks;

  AssignmentModel({
    this.id = "<!id>",
    this.uploadDate,
    this.dueDate,
    this.title = "<!title>",
    this.classId,
    this.resubmissionsAllowed = -1,
    this.status = "<!status>",
    this.resubmissionDeadline,
    this.description = "<!description>",
    this.filename = "<!filename>",
    this.filePath = "<!filePath>",
    this.fileSize = -1,
    this.fileType = "<!fileType>",
    this.submissions = const [],
    this.marks = -1,
  });

  AssignmentModel copyWith({
    String? id,
    DateTime? uploadDate,
    DateTime? dueDate,
    String? title,
    ClassModel? classId,
    int? resubmissionsAllowed,
    String? status,
    DateTime? resubmissionDeadline,
    String? description,
    String? filename,
    String? filePath,
    int? fileSize,
    String? fileType,
    List<SubmissionModel>? submissions,
    int? marks,
  }) =>
      AssignmentModel(
        id: id ?? this.id,
        uploadDate: uploadDate ??
            this.uploadDate ??
            DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        dueDate: dueDate ??
            this.dueDate ??
            DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        title: title ?? this.title,
        classId: classId ?? this.classId ?? ClassModel(),
        resubmissionsAllowed: resubmissionsAllowed ?? this.resubmissionsAllowed,
        status: status ?? this.status,
        resubmissionDeadline: resubmissionDeadline ??
            this.resubmissionDeadline ??
            DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        description: description ?? this.description,
        filename: filename ?? this.filename,
        filePath: filePath ?? this.filePath,
        fileSize: fileSize ?? this.fileSize,
        fileType: fileType ?? this.fileType,
        submissions: submissions ?? this.submissions,
        marks: marks ?? this.marks,
      );

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      AssignmentModel(
        id: json["_id"] ?? "<!id>",
        uploadDate: json["uploadDate"] != null
            ? DateTime.parse(json["uploadDate"])
            : DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        dueDate: json["dueDate"] != null
            ? DateTime.parse(json["dueDate"])
            : DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        title: json["title"] ?? "<!title>",
        classId: json["classId"] != null
            ? ClassModel.fromJson(json["classId"])
            : ClassModel(),
        resubmissionsAllowed: json["resubmissionsAllowed"],
        status: json["status"] ?? "<!status>",
        resubmissionDeadline: json["resubmissionDeadline"] != null
            ? DateTime.parse(json["resubmissionDeadline"])
            : DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        description: json["description"] ?? "<!description>",
        filename: json["filename"] ?? "<!filename>",
        filePath: json["filePath"] ?? "<!filePath>",
        fileSize: json["fileSize"] ?? -1,
        fileType: json["fileType"] ?? "<!fileType>",
        submissions: json["submissions"] != null
            ? List<SubmissionModel>.from(
                json["submissions"].map((x) => SubmissionModel.fromJson(x)))
            : [],
        marks: json["marks"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uploadDate": uploadDate != null ? uploadDate!.toIso8601String() : null,
        "dueDate": dueDate != null ? dueDate!.toIso8601String() : null,
        "title": title,
        "classId": classId != null ? classId!.toJson() : null,
        "resubmissionsAllowed": resubmissionsAllowed,
        "status": status,
        "resubmissionDeadline": resubmissionDeadline != null
            ? resubmissionDeadline!.toIso8601String()
            : null,
        "description": description,
        "filename": filename,
        "filePath": filePath,
        "fileSize": fileSize,
        "fileType": fileType,
        "submissions": List<dynamic>.from(submissions.map((x) => x.toJson())),
        "marks": marks,
      };
}
