class ClassEntity {
  Map<String, dynamic> semester;
  Map<String, dynamic> course;
  Map<String, dynamic> teacher;
  String syllabus;
  List<Map<String, dynamic>> studentList;
  List<Map<String, dynamic>> ta;
  Map<String, dynamic> channel;
  List<Map<String, dynamic>> announcements;
  List<Map<String, dynamic>> quizzes;
  List<Map<String, dynamic>> resources;
  List<Map<String, dynamic>> assignments;

  ClassEntity({
    required this.semester,
    required this.course,
    required this.teacher,
    this.syllabus = "Syllabus not available",
    required this.studentList,
    this.ta = const [],
    required this.channel,
    required this.announcements,
    this.quizzes = const [],
    this.resources = const [],
    required this.assignments,
  });
}
