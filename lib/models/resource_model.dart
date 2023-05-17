import 'package:front_end/models/user_model.dart';

class ResourceModel {
  String id = "<!id>";
  UserModel? uploadedBy;
  DateTime? dateUploaded;
  String title;
  String description;
  List<File> files;
  // int fileSize;
  // String fileType;
  // String fileLink;
  // String fileName;

  ResourceModel(
      {this.id = "<!id>",
      this.uploadedBy,
      this.dateUploaded,
      this.title = "<!title>",
      this.description = "<!description>",
      this.files = const []
      // this.fileSize = -1,
      // this.fileType = "<!fileType>",
      // this.fileLink = "<!fileLink>",
      // this.fileName = "<!fileName>",
      });

  ResourceModel copyWith(
          {String? id,
          UserModel? uploadedBy,
          DateTime? dateUploaded,
          String? title,
          String? description,
          List<File>? files
          // int? fileSize,
          // String? fileType,
          // String? fileLink,
          // String? fileName,
          }) =>
      ResourceModel(
        id: id ?? this.id,
        uploadedBy: uploadedBy ?? this.uploadedBy ?? UserModel(),
        dateUploaded: dateUploaded ??
            this.dateUploaded ??
            DateTime(2000, 02, 15, 00, 00, 00, 00, 00),
        title: title ?? this.title,
        description: description ?? this.description,
        files: files ?? this.files
        // fileSize: fileSize ?? this.fileSize,
        // fileType: fileType ?? this.fileType,
        // fileLink: fileLink ?? this.fileLink,
        // fileName: fileName ?? this.fileName,
      );

  factory ResourceModel.fromJson(Map<String, dynamic> json) => ResourceModel(
      id: json["_id"] ?? "<!id>",
      uploadedBy: json["uploadedBy"] == null
          ? null
          : UserModel.fromJson(json["uploadedBy"]),
      dateUploaded: json["uploadDate"] == null
          ? DateTime(2000, 02, 15, 00, 00, 00, 00, 00)
          : DateTime.parse(json["uploadDate"]),
      title: json["title"] ?? "<!title>",
      description: json["description"] ?? "<!description>",
      files: json["files"] == null ? [] : List<File>.from(json["files"].map((x) => File.fromJson(x))),
      // fileSize: json["fileSize"] ?? -1,
      // fileType: json["fileType"] ?? "<!fileType>",
      // fileLink: json["fileLink"] ?? "<!fileLink>",
      // fileName: json["fileName"] ?? "<!fileName>",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uploadedBy": uploadedBy == null ? null : uploadedBy!.toJson(),
        "uploadDate": dateUploaded == null
            ? DateTime(2000, 02, 15, 00, 00, 00, 00, 00).toIso8601String()
            : dateUploaded!.toIso8601String(),
        "title": title,
        "description": description,
        "files": List<dynamic>.from(files.map((x) => x.toJson()))
        // "fileSize": fileSize,
        // "fileType": fileType,
        // "fileLink": fileLink,
        // "fileName": fileName,
      };
}

class File {
  String id = "<!id>";
  String url;
  String publicId;

  File(
      {this.id = "<!id>",
      this.url = "<!url>",
      this.publicId = "<!publicId>"
      });

  File copyWith(
          {String? id,
          String? url,
          String? publicId
          }) =>
      File(
        id: id ?? this.id,
        url: url ?? this.url,
        publicId: publicId ?? this.publicId,
      );

  factory File.fromJson(Map<String, dynamic> json) => File(
      id: json["_id"] ?? "<!id>",
      url: json["url"] ?? "<!url>",
      publicId: json["public_id"] ?? "<!publicId>"
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "url": url,
        "public_id": publicId
      };
}



