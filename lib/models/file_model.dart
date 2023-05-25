class FileModel {
  String id;
  String publicId;
  String url;

  FileModel({required this.id, required this.publicId, required this.url});

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        id: json["_id"] ?? "<!id>",
        publicId: json["public_id"] ?? "<!public_id>",
        url: json["url"] ?? "<!url>",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "public_id": publicId,
        "url": url,
      };
}
