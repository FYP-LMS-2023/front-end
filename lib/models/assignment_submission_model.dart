import 'package:front_end/models/user_model.dart';

import 'file_model.dart';

class AssignmentSubmissionModel {
  String? id;
  DateTime? uploadDate;
  List<FileModel>? files;
  int? marksReceived;
  String? submissionDescription;
  int? submissionNumber;
  UserModel? studentId;
  bool? returned;
  DateTime? returnDate;
  String? returnDescription;

  AssignmentSubmissionModel({
    this.id,
    this.uploadDate,
    this.files,
    this.marksReceived,
    this.submissionDescription,
    this.submissionNumber,
    this.studentId,
    this.returned,
    this.returnDate,
    this.returnDescription,
  });

  factory AssignmentSubmissionModel.fromJson(Map<String, dynamic> json) =>
      AssignmentSubmissionModel(
        id: json["_id"] ?? "<!id>",
        uploadDate: json["uploadDate"] != null
            ? DateTime.parse(json["uploadDate"])
            : DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        files: json["files"] != null
            ? List<FileModel>.from(
                json["files"].map((x) => FileModel.fromJson(x)))
            : null,
        marksReceived: json["marksReceived"] ?? -1,
        submissionDescription:
            json["submissionDescription"] ?? "<!submissionDescription>",
        submissionNumber: json["submissionNumber"] ?? -1,
        studentId: json["studentID"] != null
            ? UserModel.fromJson(json["studentID"])
            : UserModel(),
        returned: json["returned"] ?? false,
        returnDate: json["returnDate"] != null
            ? DateTime.parse(json["returnDate"])
            : DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        returnDescription: json["returnDescription"] ?? "<!returnDescription>",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uploadDate": uploadDate != null ? uploadDate!.toIso8601String() : null,
        "files": List<dynamic>.from(files!.map((x) => x.toJson())),
        "marksReceived": marksReceived,
        "submissionDescription": submissionDescription,
        "submissionNumber": submissionNumber,
        "studentID": studentId != null ? studentId!.toJson() : null,
        "returned": returned,
        "returnDate": returnDate,
        "returnDescription": returnDescription,
      };
}