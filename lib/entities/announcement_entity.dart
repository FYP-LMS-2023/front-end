class AnnouncementEntity {
  final String title;
  final String description;
  final DateTime uploadDate;
  final String postedBy;

  AnnouncementEntity({
    required this.title,
    required this.description,
    required this.uploadDate,
    required this.postedBy,
  });
}
