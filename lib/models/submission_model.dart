import 'package:front_end/models/assignment_model.dart';
import 'package:front_end/models/user_model.dart';

class SubmissionModel {
  String id;
  UserModel? studentId;
  String submissionText;
  List<Attachment> attachments;
  int marksRecieved;
  DateTime? dateSubmitted;
  AssignmentModel? submittedFor;
  String submissionType;
  DateTime? submissionDate;
  String submissionStatus;
  int submissionNumber;
  List<FeedbackModel> submissionReturned;
  int submissionGrade;

  SubmissionModel({
    this.id = "<!id>",
    this.studentId,
    this.submissionText = "<!submissionText>",
    this.attachments = const [],
    this.marksRecieved = -1,
    this.dateSubmitted,
    this.submittedFor,
    this.submissionType = "<!submissionType>",
    this.submissionDate,
    this.submissionStatus = "<!submissionStatus>",
    this.submissionNumber = -1,
    this.submissionReturned = const [],
    this.submissionGrade = -1,
  });

  SubmissionModel copyWith({
    String? id,
    UserModel? studentId,
    String? submissionText,
    List<Attachment>? attachments,
    int? marksRecieved,
    DateTime? dateSubmitted,
    AssignmentModel? submittedFor,
    String? submissionType,
    DateTime? submissionDate,
    String? submissionStatus,
    int? submissionNumber,
    List<FeedbackModel>? submissionReturned,
    int? submissionGrade,
  }) =>
      SubmissionModel(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId ?? UserModel(),
        submissionText: submissionText ?? this.submissionText,
        attachments: attachments ?? this.attachments,
        marksRecieved: marksRecieved ?? this.marksRecieved,
        dateSubmitted: dateSubmitted ??
            this.dateSubmitted ??
            DateTime(2000, 02, 15, 00, 00, 00, 00, 00),
        submittedFor: submittedFor ?? this.submittedFor ?? AssignmentModel(),
        submissionType: submissionType ?? this.submissionType,
        submissionDate: submissionDate ??
            this.submissionDate ??
            DateTime(2000, 02, 15, 00, 00, 00, 00, 00),
        submissionStatus: submissionStatus ?? this.submissionStatus,
        submissionNumber: submissionNumber ?? this.submissionNumber,
        submissionReturned: submissionReturned ?? this.submissionReturned,
        submissionGrade: submissionGrade ?? this.submissionGrade,
      );

  factory SubmissionModel.fromJson(Map<String, dynamic> json) =>
      SubmissionModel(
        id: json["_id"] ?? "<!id>",
        studentId: json["studentID"] == null
            ? null
            : UserModel.fromJson(json["studentID"]),
        submissionText: json["submissionText"] ?? "<!submissionText>",
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"].map((x) => Attachment.fromJson(x))),
        marksRecieved: json["marksRecieved"] ?? -1,
        dateSubmitted: json["dateSubmitted"] == null
            ? DateTime(2000, 02, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["dateSubmitted"]),
        submittedFor: json["submittedFor"] == null
            ? AssignmentModel()
            : AssignmentModel.fromJson(json["submittedFor"]),
        submissionType: json["submissionType"] ?? "<!submissionType>",
        submissionDate: json["submissionDate"] == null
            ? DateTime(2000, 02, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["submissionDate"]),
        submissionStatus: json["submissionStatus"] ?? "<!submissionStatus>",
        submissionNumber: json["submissionNumber"] ?? -1,
        submissionReturned: json["submissionReturned"] == null
            ? []
            : List<FeedbackModel>.from(json["submissionReturned"]
                .map((x) => FeedbackModel.fromJson(x))),
        submissionGrade: json["submissionGrade"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "studentID": studentId == null ? null : studentId!.toJson(),
        "submissionText": submissionText,
        "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
        "marksRecieved": marksRecieved,
        "dateSubmitted":
            dateSubmitted == null ? null : dateSubmitted!.toIso8601String(),
        "submittedFor": submittedFor == null ? null : submittedFor!.toJson(),
        "submissionType": submissionType,
        "submissionDate":
            submissionDate == null ? null : submissionDate!.toIso8601String(),
        "submissionStatus": submissionStatus,
        "submissionNumber": submissionNumber,
        "submissionReturned":
            List<dynamic>.from(submissionReturned.map((x) => x.toJson())),
        "submissionGrade": submissionGrade,
      };
}

class Attachment {
  String id;
  String filename;
  String fileLink;
  int fileSize;
  String fileType;

  Attachment({
    this.id = "<!id>",
    this.filename = "<!filename>",
    this.fileLink = "<!fileLink>",
    this.fileSize = -1,
    this.fileType = "<!fileType>",
  });

  Attachment copyWith({
    String? id,
    String? filename,
    String? fileLink,
    int? fileSize,
    String? fileType,
  }) =>
      Attachment(
        id: id ?? this.id,
        filename: filename ?? this.filename,
        fileLink: fileLink ?? this.fileLink,
        fileSize: fileSize ?? this.fileSize,
        fileType: fileType ?? this.fileType,
      );

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["_id"] ?? "<!id>",
        filename: json["filename"] ?? "<!filename>",
        fileLink: json["file"] ?? "<!fileLink>",
        fileSize: json["fileSize"] ?? -1,
        fileType: json["fileType"] ?? "<!fileType>",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "filename": filename,
        "file": fileLink,
        "fileSize": fileSize,
        "fileType": fileType,
      };
}

class FeedbackModel {
  String id;
  String comment;
  UserModel? commentedBy;
  DateTime? dateCommented;

  FeedbackModel({
    this.id = "<!id>",
    this.comment = "<!comment>",
    this.commentedBy,
    this.dateCommented,
  });

  FeedbackModel copyWith({
    String? id,
    String? comment,
    UserModel? commentedBy,
    DateTime? dateCommented,
  }) =>
      FeedbackModel(
          id: id ?? this.id,
          comment: comment ?? this.comment,
          commentedBy: commentedBy ?? this.commentedBy ?? UserModel(),
          dateCommented: dateCommented ??
              this.dateCommented ??
              DateTime(2000, 02, 15, 00, 00, 00, 00, 00));

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        id: json["_id"] ?? "<!id>",
        comment: json["comment"],
        commentedBy: json["commentedBy"] == null
            ? UserModel()
            : UserModel.fromJson(json["commentedBy"]),
        dateCommented: json["dateCommented"] == null
            ? DateTime(2000, 02, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["dateCommented"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "comment": comment,
        "commentedBy": commentedBy == null ? null : commentedBy!.toJson(),
        "dateCommented":
            dateCommented == null ? null : dateCommented!.toIso8601String(),
      };
}
