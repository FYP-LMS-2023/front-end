import 'package:flutter/material.dart';
import 'package:front_end/entities/class_entity.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/models/mock_data.dart';



class ClassProvider extends ChangeNotifier {
  // final ClassModel _class = mockClass;

  List<ClassEntity> list = [];

  List<ClassEntity> get getClasses => list;

  void loadClasses() {
    list = [];
    ClassModel classModel = ClassModel.fromJson(classJSON);

    ClassEntity myclass = ClassEntity(
      semester: classModel.semester,
      courseCode: classModel.courseCode,
      courseName: classModel.courseName,
      teacherName: classModel.teacherName,
      syllabus: classModel.syllabus,
      students: classModel.students,
      ta: classModel.ta,
      announcements: classModel.announcements,
      quizes: classModel.quizes,
      resources: classModel.resources,
      assignments: classModel.assignments,
      attendance: classModel.attendance,
    );
    list.add(myclass);
  }

  @override
  notifyListeners();
  // ClassModel get getClass => _class;
}
