class CourseEntity {
  final String courseCode;
  final String courseName;
  final int creditHours;
  final String courseDescription;
  final List<Map<String, dynamic>>? classes;

  CourseEntity({
    required this.courseCode,
    required this.courseName,
    required this.creditHours,
    required this.courseDescription,
    this.classes,
  });
}
