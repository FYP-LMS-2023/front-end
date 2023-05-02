import 'package:front_end/models/user_model.dart';

class CommentModel {
  String id;
  String comment;
  UserModel? postedBy;
  DateTime? datePosted;
  List<Reply> replies;

  CommentModel({
    this.id = "<!id>",
    this.comment = "<!comment>",
    this.postedBy,
    this.datePosted,
    this.replies = const [],
  });

  CommentModel copyWith({
    String? id,
    String? comment,
    UserModel? postedBy,
    DateTime? datePosted,
    List<Reply>? replies,
  }) =>
      CommentModel(
        id: id ?? this.id,
        comment: comment ?? this.comment,
        postedBy: postedBy ?? this.postedBy ?? UserModel(),
        datePosted: datePosted ??
            this.datePosted ??
            DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        replies: replies ?? this.replies,
      );

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["_id"] ?? "<!id>",
        comment: json["comment"] ?? "<!comment>",
        postedBy: json["postedBy"] == null
            ? UserModel()
            : UserModel.fromJson(json["postedBy"]),
        datePosted: json["datePosted"] == null
            ? DateTime(2000, 2, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["datePosted"]),
        replies: json["replies"] == null
            ? []
            : List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "comment": comment,
        "postedBy": postedBy != null ? postedBy!.toJson() : null,
        "datePosted": datePosted != null ? datePosted!.toIso8601String() : null,
        "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
      };
}

class Reply {
  String id;
  UserModel? userId;
  String repliedComment;
  DateTime? datePosted;

  Reply({
    this.id = "<!id>",
    this.userId,
    this.repliedComment = "<!repliedComment>",
    this.datePosted,
  });

  Reply copyWith({
    String? id,
    UserModel? userId,
    String? repliedComment,
    DateTime? datePosted,
  }) =>
      Reply(
          id: id ?? this.id,
          userId: userId ?? this.userId ?? UserModel(),
          repliedComment: repliedComment ?? this.repliedComment,
          datePosted: datePosted ??
              this.datePosted ??
              DateTime(2000, 2, 15, 00, 00, 00, 00, 00));

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json["_id"] ?? "<!id>",
        userId: json["userID"] == null
            ? UserModel()
            : UserModel.fromJson(json["userID"]),
        repliedComment: json["repliedComment"] ?? "<!repliedComment>",
        datePosted: json["datePosted"] == null
            ? DateTime(2000, 2, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["datePosted"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userID": userId != null ? userId!.toJson() : null,
        "repliedComment": repliedComment,
        "datePosted": datePosted != null ? datePosted!.toIso8601String() : null,
      };
}
