import 'package:front_end/models/user_model.dart';

class AnnouncementModel {
  String id;
  String title;
  String description;
  UserModel? postedBy;
  DateTime? datePosted;
  String announcementType;

  AnnouncementModel({
    this.id = "<!id>",
    this.title = "<!title>",
    this.description = "<!description>",
    this.postedBy,
    this.datePosted,
    this.announcementType = "<!announcementType>",
  });

  AnnouncementModel copyWith({
    String? id,
    String? title,
    String? description,
    UserModel? postedBy,
    DateTime? datePosted,
    String? announcementType,
  }) =>
      AnnouncementModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        postedBy: postedBy ?? this.postedBy ?? UserModel(),
        datePosted: datePosted ??
            this.datePosted ??
            DateTime(2000, 02, 15, 00, 00, 00, 00, 00),
        announcementType: announcementType ?? this.announcementType,
      );

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    print('AnnouncementModel.fromJson: json = $json');
    return AnnouncementModel(
      id: json["_id"] ?? "<!id>",
      title: json["title"] ?? "<!title>",
      description: json["description"] ?? "<!description>",
      postedBy: json["postedBy"] == null
          ? UserModel()
          : UserModel.fromJson(json["postedBy"]),
      datePosted: json["datePosted"] == null
          ? DateTime(2000, 02, 15, 00, 00, 00, 00, 00)
          : DateTime.parse(json["datePosted"]),
      announcementType: json["announcementType"] ?? "<!announcementType>",
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "postedBy": postedBy == null ? null : postedBy!.toJson(),
        // "datePosted": datePosted.toIso8601String(),
        "datePosted": datePosted == null ? null : datePosted!.toIso8601String(),
        "announcementType": announcementType,
      };
}
