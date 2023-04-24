import 'package:flutter/material.dart';
import 'package:front_end/entities/class_entity.dart';
import 'package:front_end/models/class_model.dart';
import 'package:front_end/models/mock_data.dart';

class ClassProvider extends ChangeNotifier {
  List<ClassEntity> list = [];

  List<ClassEntity> get getClasses => list;

  void loadClasses() {
    list = [];
    for (int i = 0; i < classesJSON.length; i++) {
      ClassModel classModel = ClassModel.fromJson(classesJSON[i]);

      //null check operator used to avoid null exception
      //must implemment empty checks in the UI
      ClassEntity myclass = ClassEntity(
        semester: classModel.semester,
        course: classModel.course,
        teacher: classModel.teacher,
        syllabus: classModel.syllabus!,
        studentList: classModel.studentList,
        ta: classModel.ta!,
        channel: classModel.channel,
        announcements: classModel.announcements,
        quizzes: classModel.quizzes!,
        resources: classModel.resources!,
        assignments: classModel.assignments,
      );
      list.add(myclass);
    }
  }

  @override
  notifyListeners();
  // ClassModel get getClass => _class;
}
