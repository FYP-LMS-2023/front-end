class ClassModel {
  final Map<String, dynamic> semester;
  final Map<String, dynamic> course;
  final Map<String, dynamic> teacher;
  String? syllabus;
  final List<Map<String, dynamic>> studentList;
  List<Map<String, dynamic>>? ta;
  final Map<String, dynamic> channel;
  final List<Map<String, dynamic>> announcements;
  List<Map<String, dynamic>>? quizzes;
  List<Map<String, dynamic>>? resources;
  final List<Map<String, dynamic>> assignments;

  ClassModel({
    required this.semester,
    required this.course,
    required this.teacher,
    this.syllabus,
    required this.studentList,
    this.ta,
    required this.channel,
    required this.announcements,
    this.quizzes,
    this.resources,
    required this.assignments,
  });

  static fromJson(Map<String, dynamic> json) {
    return ClassModel(
      semester: json['semester'],
      course: json['course'],
      teacher: json['teacher'],
      syllabus: json['syllabus'],
      studentList: json['student_list'],
      ta: json['ta'],
      channel: json['channel'],
      announcements: json['announcements'],
      quizzes: json['quizzes'],
      resources: json['resources'],
      assignments: json['assignments'],
    );
  }

  toJson() {
    return {
      'semester': semester,
      'course': course,
      'teacher': teacher,
      'syllabus': syllabus,
      'studentList': studentList,
      'ta': ta,
      'channel': channel,
      'announcements': announcements,
      'quizzes': quizzes,
      'resources': resources,
      'assignments': assignments,
    };
  }
}
