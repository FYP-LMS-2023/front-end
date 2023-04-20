class AssignmentEntity {
  final DateTime uploadDate;
  final DateTime dueDate;
  final String title;
  final int resubmissionsAllowed;
  final String status;
  final DateTime? resubmissionDeadline;
  final String description;
  final String teacherName;
  final int marks;
  final List<Map<String, dynamic>>? submissions;
  final List<Map<String, dynamic>>? attachments;

  AssignmentEntity({
    required this.uploadDate,
    required this.dueDate,
    required this.title,
    required this.resubmissionsAllowed,
    required this.status,
    this.resubmissionDeadline,
    required this.description,
    this.attachments,
    required this.teacherName,
    this.submissions,
    required this.marks,
  });
}
