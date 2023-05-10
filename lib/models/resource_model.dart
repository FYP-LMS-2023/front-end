import 'package:front_end/models/user_model.dart';

class ResourceModel {
  String id = "<!id>";
  UserModel? uploadedBy;
  DateTime? dateUploaded;
  int fileSize;
  String fileType;
  String fileLink;
  String fileName;

  ResourceModel({
    this.id = "<!id>",
    this.uploadedBy,
    this.dateUploaded,
    this.fileSize = -1,
    this.fileType = "<!fileType>",
    this.fileLink = "<!fileLink>",
    this.fileName = "<!fileName>",
  });

  ResourceModel copyWith({
    String? id,
    UserModel? uploadedBy,
    DateTime? dateUploaded,
    int? fileSize,
    String? fileType,
    String? fileLink,
    String? fileName,
  }) =>
      ResourceModel(
        id: id ?? this.id,
        uploadedBy: uploadedBy ?? this.uploadedBy ?? UserModel(),
        dateUploaded: dateUploaded ??
            this.dateUploaded ??
            DateTime(2000, 02, 15, 00, 00, 00, 00, 00),
        fileSize: fileSize ?? this.fileSize,
        fileType: fileType ?? this.fileType,
        fileLink: fileLink ?? this.fileLink,
        fileName: fileName ?? this.fileName,
      );

  factory ResourceModel.fromJson(Map<String, dynamic> json) => ResourceModel(
        id: json["_id"] ?? "<!id>",
        uploadedBy: json["uploadedBy"] == null
            ? null
            : UserModel.fromJson(json["uploadedBy"]),
        dateUploaded: json["dateUploaded"] == null
            ? DateTime(2000, 02, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["dateUploaded"]),
        fileSize: json["fileSize"] ?? -1,
        fileType: json["fileType"] ?? "<!fileType>",
        fileLink: json["fileLink"] ?? "<!fileLink>",
        fileName: json["fileName"] ?? "<!fileName>",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uploadedBy": uploadedBy == null ? null : uploadedBy!.toJson(),
        "dateUploaded": dateUploaded == null
            ? DateTime(2000, 02, 15, 00, 00, 00, 00, 00).toIso8601String()
            : dateUploaded!.toIso8601String(),
        "fileSize": fileSize,
        "fileType": fileType,
        "fileLink": fileLink,
        "fileName": fileName,
      };
}
