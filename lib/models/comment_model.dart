import 'package:front_end/models/user_model.dart';

class CommentModel {
  String id;
  String comment;
  UserModel? postedBy;
  DateTime? datePosted;
  List<Reply> replies;
  List<String> upvotes;
  List<String> downvotes;
  int upVoteCount;
  int downVoteCount;

  CommentModel({
    this.id = "<!id>",
    this.comment = "<!comment>",
    this.postedBy,
    this.datePosted,
    this.replies = const [],
    this.upvotes = const [],
    this.downvotes = const [],
    this.upVoteCount = 0,
    this.downVoteCount = 0,
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
        upvotes: json["upvotes"] == null
            ? []
            : List<String>.from(json["upvotes"].map((x) => (x))),
        downvotes: json["downvotes"] == null
            ? []
            : List<String>.from(json["downvotes"].map((x) => (x))),
        upVoteCount: json["upvoteCount"] ?? -1,
        downVoteCount: json["downvoteCount"] ?? -1,
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
  UserModel? postedBy;
  String reply;
  DateTime? datePosted;
  List<String> upvotes;
  List<String> downvotes;
  int upVoteCount;
  int downVoteCount;

  Reply({
    this.id = "<!id>",
    this.postedBy,
    this.reply = "<!repliedComment>",
    this.datePosted,
    this.upvotes = const [],
    this.downvotes = const [],
    this.upVoteCount = 0,
    this.downVoteCount = 0,
  });

  Reply copyWith({
    String? id,
    UserModel? userId,
    String? repliedComment,
    DateTime? datePosted,
  }) =>
      Reply(
          id: id ?? this.id,
          postedBy: userId ?? this.postedBy ?? UserModel(),
          reply: repliedComment ?? this.reply,
          datePosted: datePosted ??
              this.datePosted ??
              DateTime(2000, 2, 15, 00, 00, 00, 00, 00));

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json["_id"] ?? "<!id>",
        postedBy: json["postedBy"] == null
            ? UserModel()
            : UserModel.fromJson(json["postedBy"]),
        reply: json["reply"] ?? "<!repliedComment>",
        datePosted: json["datePosted"] == null
            ? DateTime(2000, 2, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["datePosted"]),
        upvotes: json["upvotes"] == null
            ? []
            : List<String>.from(json["upvotes"].map((x) => (x))),
        downvotes: json["downvotes"] == null
            ? []
            : List<String>.from(json["downvotes"].map((x) => (x))),
        upVoteCount: json["upvoteCount"] ?? -1,
        downVoteCount: json["downvoteCount"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userID": postedBy != null ? postedBy!.toJson() : null,
        "repliedComment": reply,
        "datePosted": datePosted != null ? datePosted!.toIso8601String() : null,
      };
}
