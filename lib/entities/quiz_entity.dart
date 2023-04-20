class QuizEntity {
  final String title;
  final String description;
  final DateTime uploadDate;
  final DateTime dueDate;
  final DateTime startDate;
  final String status;
  final int resubmissionsAllowed;
  final DateTime? resubmissionDeadline;
  final int marks;
  final List<Map<String, dynamic>>? attachments;
  final List<Map<String, dynamic>>? submissions;
  final List<Map<String, dynamic>> questions;

  QuizEntity({
    required this.title,
    required this.description,
    required this.uploadDate,
    required this.dueDate,
    required this.startDate,
    required this.status,
    required this.resubmissionsAllowed,
    this.resubmissionDeadline,
    required this.marks,
    this.attachments,
    this.submissions,
    required this.questions,
  });
}
