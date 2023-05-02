import 'package:front_end/models/class_model.dart';

class CourseModel {
  String id;
  String courseCode;
  String courseName;
  int creditHours;
  String courseDescription;
  List<ClassModel> classes;

  CourseModel({
    this.id = "<!id>",
    this.courseCode = "<!courseCode>",
    this.courseName = "<!courseName>",
    this.creditHours = -1,
    this.courseDescription = "<!courseDescription>",
    this.classes = const [],
  });

  CourseModel copyWith({
    String? id,
    String? courseCode,
    String? courseName,
    int? creditHours,
    String? courseDescription,
    List<ClassModel>? classes,
  }) =>
      CourseModel(
        id: id ?? this.id,
        courseCode: courseCode ?? this.courseCode,
        courseName: courseName ?? this.courseName,
        creditHours: creditHours ?? this.creditHours,
        courseDescription: courseDescription ?? this.courseDescription,
        classes: classes ?? this.classes,
      );

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json["_id"] ?? "<!id>",
        courseCode: json["courseCode"] ?? "<!courseCode>",
        courseName: json["courseName"] ?? "<!courseName>",
        creditHours: json["creditHours"] ?? -1,
        courseDescription: json["courseDescription"] ?? "<!courseDescription>",
        // classes: List<ClassModel>.from(
        //     json["classes"].map((x) => ClassModel.fromJson(x))),
        classes: json["classes"] != null
            ? List<ClassModel>.from(
                json["classes"].map((x) => ClassModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "courseCode": courseCode,
        "courseName": courseName,
        "creditHours": creditHours,
        "courseDescription": courseDescription,
        "classes": List<dynamic>.from(classes.map((x) => x.toJson())),
      };
}
