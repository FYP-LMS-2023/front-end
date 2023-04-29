class QuizModel {
  late String title;
  late String description;
  late DateTime uploadDate;
  late DateTime dueDate;
  late DateTime startDate;
  late String status;
  late int resubmissionsAllowed;
  DateTime? resubmissionDeadline;
  late int marks;
  List<Map<String, dynamic>>? attachments;
  List<Map<String, dynamic>>? submissions;
  late List<Map<String, dynamic>> questions;

  QuizModel({
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

  QuizModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    uploadDate = json['uploadDate'];
    dueDate = json['dueDate'];
    startDate = json['startDate'];
    status = json['status'];
    resubmissionsAllowed = json['resubmissionsAllowed'];
    resubmissionDeadline = json['resubmissionDeadline'];
    marks = json['marks'];
    if (json['attachments'] != null) {
      attachments = <Map<String, dynamic>>[];
      json['attachments'].forEach((v) {
        attachments?.add(v);
      });
    }
    if (json['submissions'] != null) {
      submissions = <Map<String, dynamic>>[];
      json['submissions'].forEach((v) {
        submissions?.add(v);
      });
    } 
    if (json['questions'] != null) {
      questions = <Map<String, dynamic>>[];
      json['questions'].forEach((v) {
        questions.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['uploadDate'] = uploadDate;
    data['dueDate'] = dueDate;
    data['startDate'] = startDate;
    data['status'] = status;
    data['resubmissionsAllowed'] = resubmissionsAllowed;
    data['resubmissionDeadline'] = resubmissionDeadline;
    data['marks'] = marks;
    if (attachments != null) {
      data['attachments'] = attachments?.map((v) => v).toList();
    }
    if (submissions != null) {
      data['submissions'] = submissions?.map((v) => v).toList();
    }
    data['questions'] = questions.map((v) => v).toList();
    return data;
  }
}
