import 'package:front_end/models/thread_model.dart';

class ChannelModel {
  String channelId;
  List<ThreadModel> threads;

  ChannelModel({
    this.channelId = "<!id>",
    this.threads = const [],
  });

  ChannelModel copyWith({
    String? id,
    List<ThreadModel>? threads,
  }) =>
      ChannelModel(
        channelId: id ?? channelId,
        threads: threads ?? this.threads,
      );

  factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
        channelId: json["channelID"] ?? "<!id>",
        threads: json["threads"] == null
            ? []
            : List<ThreadModel>.from(
                json["threads"].map((x) => ThreadModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "threads": List<dynamic>.from(threads.map((x) => x)),
      };
}
