import 'package:flutter/material.dart';
import 'package:front_end/entities/course_entity.dart';
import 'package:front_end/models/course_model.dart';
import 'package:front_end/models/mock_data.dart';

class CourseProvider extends ChangeNotifier {
  List<CourseEntity> list = [];
  List<CourseEntity> get getCourses => list;

  void loadCourses() {
    list = [];
    CourseModel courseModel = CourseModel.fromJson(courseJSON);

    CourseEntity course = CourseEntity(
      courseCode: courseModel.courseCode,
      courseName: courseModel.courseName,
      creditHours: courseModel.creditHours,
      courseDescription: courseModel.courseDescription,
      classes: courseModel.classes,
    );

    list.add(course);
  }
}
