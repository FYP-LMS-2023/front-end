class Assignment {
  late DateTime uploadDate;
  late DateTime dueDate;
  late String title;
  late int resubmissionsAllowed;
  late String status;
  DateTime? resubmissionDeadline;
  late String description;
  late String teacherName;
  late int marks;
  List<Map<String, dynamic>>? submissions;
  List<Map<String, dynamic>>? attachments;

  Assignment(
      {required this.uploadDate,
      required this.dueDate,
      required this.title,
      required this.resubmissionsAllowed,
      required this.status,
      this.resubmissionDeadline,
      required this.description,
      this.attachments,
      required this.teacherName,
      this.submissions,
      required this.marks});

  Assignment.fromJson(Map<String, dynamic> json) {
    uploadDate = json['uploadDate'];
    dueDate = json['dueDate'];
    title = json['title'];
    resubmissionsAllowed = json['resubmissionsAllowed'];
    status = json['status'];
    resubmissionDeadline = json['resubmissionDeadline'];
    description = json['description'];
    teacherName = json['teacherName'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uploadDate'] = uploadDate;
    data['dueDate'] = dueDate;
    data['title'] = title;
    data['resubmissionsAllowed'] = resubmissionsAllowed;
    data['status'] = status;
    data['resubmissionDeadline'] = resubmissionDeadline;
    data['teacherName'] = teacherName;
    data['description'] = description;
    if (attachments != null) {
      data['attachments'] = attachments?.map((v) => v).toList();
    }
    if (submissions != null) {
      data['submissions'] = submissions?.map((v) => v).toList();
    }
    data["marks"] = marks;
    return data;
  }
}
