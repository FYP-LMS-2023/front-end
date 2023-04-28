class ClassEntity {
  final String semester;
  final String courseCode;
  final String courseName;
  final String teacherName;
  final String? syllabus;
  final List<Map<String, dynamic>> students;
  final List<Map<String, dynamic>>? ta;
  final List<Map<String, dynamic>> announcements;
  final List<Map<String, dynamic>>? quizes;
  final List<Map<String, dynamic>> resources;
  final List<Map<String, dynamic>> assignments;
  final List<Map<String, dynamic>> attendance;

  ClassEntity({
    required this.semester,
    required this.courseCode,
    required this.courseName,
    required this.teacherName,
    this.syllabus,
    required this.students,
    this.ta,
    required this.announcements,
    this.quizes,
    required this.resources,
    required this.assignments,
    required this.attendance,
  });
}