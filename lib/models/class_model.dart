class ClassModel {
  late String semester;
  late String teacherName;
  String? syllabus;
  late List<Map<String, dynamic>> students;
  List<Map<String, dynamic>>? ta;
  late List<Map<String, dynamic>> announcements;
  List<Map<String, dynamic>>? quizes;
  late List<Map<String, dynamic>> resources;
  late List<Map<String, dynamic>> assignments;
  late List<Map<String, dynamic>> attendance;

  ClassModel({
    required this.semester,
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

  ClassModel.fromJson(Map<String, dynamic> json) {
    semester = json['semester'];
    teacherName = json['teacherName'];
    syllabus = json['syllabus'];
    if (json['students'] != null) {
      students = <Map<String, dynamic>>[];
      json['students'].forEach((v) {
        students.add(v);
      });
    }
    if (json['ta'] != null) {
      ta = <Map<String, dynamic>>[];
      json['ta'].forEach((v) {
        ta?.add(v);
      });
    }
    if (json['announcements'] != null) {
      announcements = <Map<String, dynamic>>[];
      json['announcements'].forEach((v) {
        announcements.add(v);
      });
    }
    if (json['quizes'] != null) {
      quizes = <Map<String, dynamic>>[];
      json['quizes'].forEach((v) {
        quizes?.add(v);
      });
    }
    if (json['resources'] != null) {
      resources = <Map<String, dynamic>>[];
      json['resources'].forEach((v) {
        resources.add(v);
      });
    }
    if (json['assignments'] != null) {
      assignments = <Map<String, dynamic>>[];
      json['assignments'].forEach((v) {
        assignments.add(v);
      });
    }
    if (json['attendance'] != null) {
      attendance = <Map<String, dynamic>>[];
      json['attendance'].forEach((v) {
        attendance.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['semester'] = semester;
    data['teacherName'] = teacherName;
    data['syllabus'] = syllabus;
    if (students.isNotEmpty) {
      data['students'] = students.map((v) => v).toList();
    }
    if (ta != null) {
      data['ta'] = ta?.map((v) => v).toList();
    }
    if (announcements.isNotEmpty) {
      data['announcements'] = announcements.map((v) => v).toList();
    }
    if (quizes != null) {
      data['quizes'] = quizes?.map((v) => v).toList();
    }
    if (resources.isNotEmpty) {
      data['resources'] = resources.map((v) => v).toList();
    }
    if (assignments.isNotEmpty) {
      data['assignments'] = assignments.map((v) => v).toList();
    }
    if (attendance.isNotEmpty) {
      data['attendance'] = attendance.map((v) => v).toList();
    }
    return data;
  }
}
