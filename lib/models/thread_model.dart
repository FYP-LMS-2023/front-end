import 'package:front_end/models/comment_model.dart';
import 'package:front_end/models/user_model.dart';

class ThreadModel {
  String id;
  UserModel? postedBy;
  String title;
  String description;
  DateTime? datePosted;
  List<CommentModel> comments;
  List<String> tags;
  List<UserModel> upvotes;
  List<UserModel> downvotes;

  ThreadModel({
    this.id = "<!id>",
    this.postedBy,
    this.title = "<!title>",
    this.description = "<!description>",
    this.datePosted,
    this.comments = const [],
    this.tags = const [],
    this.upvotes = const [],
    this.downvotes = const [],
  });

  ThreadModel copyWith({
    String? id,
    UserModel? postedBy,
    String? title,
    String? description,
    DateTime? datePosted,
    List<CommentModel>? comments,
    List<String>? tags,
    List<UserModel>? upvotes,
    List<UserModel>? downvotes,
  }) =>
      ThreadModel(
        id: id ?? this.id,
        postedBy: postedBy ?? this.postedBy ?? UserModel(),
        title: title ?? this.title,
        description: description ?? this.description,
        datePosted: datePosted ??
            this.datePosted ??
            DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        comments: comments ?? this.comments,
        tags: tags ?? this.tags,
        upvotes: upvotes ?? this.upvotes,
        downvotes: downvotes ?? this.downvotes,
      );

  factory ThreadModel.fromJson(Map<String, dynamic> json) => ThreadModel(
        id: json["_id"] ?? "<!id>",
        postedBy: json["postedBy"] == null
            ? UserModel()
            : UserModel.fromJson(json["postedBy"]),
        title: json["title"],
        description: json["description"],
        datePosted: json["datePosted"] == null
            ? DateTime(2000, 2, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["datePosted"]),
        comments: List<CommentModel>.from(json["comments"].map((x) => x)),
        tags: List<String>.from(json["tags"].map((x) => x)),
        upvotes: json["upvotes"] == null
            ? []
            : List<UserModel>.from(json["upvotes"].map((x) => x)),
        downvotes: json["downvotes"] == null
            ? []
            : List<UserModel>.from(json["downvotes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "postedBy": postedBy != null ? postedBy!.toJson() : null,
        "title": title,
        "description": description,
        "datePosted": datePosted != null ? datePosted!.toIso8601String() : null,
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "upvotes": List<dynamic>.from(upvotes.map((x) => x)),
        "downvotes": List<dynamic>.from(downvotes.map((x) => x)),
      };
}
