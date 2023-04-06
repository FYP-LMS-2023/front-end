class Announcement {
  late String title;
  late String description;
  late DateTime uploadDate;
  late String postedBy;

  Announcement({
    required this.title,
    required this.description,
    required this.uploadDate,
    required this.postedBy,
  });

  Announcement.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    uploadDate = json['uploadDate'];
    postedBy = json['postedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['uploadDate'] = uploadDate;
    data['postedBy'] = postedBy;
    return data;
  }
}
