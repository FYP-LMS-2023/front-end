import 'package:flutter/material.dart';
import 'package:front_end/entities/assignment_entity.dart';
import 'package:front_end/models/assignment_model.dart';
import 'package:front_end/models/mock_data.dart';

class AssignmentProvider extends ChangeNotifier {
  List<AssignmentEntity> list = [];

  List<AssignmentEntity> get getAssignments => list;

  void loadAssignments() {
    list = [];

    AssignmentModel assignmentModel = AssignmentModel.fromJson(assignmentJSON);

    AssignmentEntity assignment = AssignmentEntity(
      uploadDate: assignmentModel.uploadDate,
      dueDate: assignmentModel.dueDate,
      title: assignmentModel.title,
      resubmissionsAllowed: assignmentModel.resubmissionsAllowed,
      status: assignmentModel.status,
      resubmissionDeadline: assignmentModel.resubmissionDeadline,
      description: assignmentModel.description,
      teacherName: assignmentModel.teacherName,
      marks: assignmentModel.marks,
      submissions: assignmentModel.submissions,
      attachments: assignmentModel.attachments,
    );
    list.add(assignment);
  }

  @override
  notifyListeners();
}
