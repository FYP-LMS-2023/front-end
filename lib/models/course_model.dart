class CourseModel {
  late String courseCode;
  late String courseName;
  late int creditHours;
  late String courseDescription;
  List<Map<String, dynamic>>? classes;

  CourseModel({
    required this.courseCode,
    required this.courseName,
    required this.creditHours,
    required this.courseDescription,
    this.classes,
  });

  CourseModel.fromJson(Map<String, dynamic> json) {
    courseCode = json['courseCode'];
    courseName = json['courseName'];
    creditHours = json['creditHours'];
    courseDescription = json['courseDescription'];
    if (json['classes'] != null) {
      classes = <Map<String, dynamic>>[];
      json['classes'].forEach((v) {
        classes?.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['courseCode'] = courseCode;
    data['courseName'] = courseName;
    data['creditHours'] = creditHours;
    data['courseDescription'] = courseDescription;
    if (classes != null) {
      data['classes'] = classes?.map((v) => v).toList();
    }
    return data;
  }
}
