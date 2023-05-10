import 'package:front_end/models/thread_model.dart';

class ChannelModel {
  String id;
  List<ThreadModel> threads;

  ChannelModel({
    this.id = "<!id>",
    this.threads = const [],
  });

  ChannelModel copyWith({
    String? id,
    List<ThreadModel>? threads,
  }) =>
      ChannelModel(
        id: id ?? this.id,
        threads: threads ?? this.threads,
      );

  factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
        id: json["_id"] ?? "<!id>",
        threads: json["threads"] == null
            ? []
            : List<ThreadModel>.from(
                json["threads"].map((x) => ThreadModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "threads": List<dynamic>.from(threads.map((x) => x)),
      };
}
