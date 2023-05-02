import 'package:front_end/models/announcement_model.dart';
import 'package:front_end/models/assignment_model.dart';
import 'package:front_end/models/attendance_model.dart';
import 'package:front_end/models/channel_model.dart';
import 'package:front_end/models/quiz_model.dart';
import 'package:front_end/models/resource_model.dart';
import 'package:front_end/models/semester_model.dart';
import 'package:front_end/models/user_model.dart';

class ClassModel {
  String id;
  SemesterModel? semesterId;
  List<UserModel> teacherIDs;
  String syllabus;
  List<UserModel> studentList;
  List<UserModel> ta;
  ChannelModel? channel;
  List<AnnouncementModel> announcement;
  List<QuizModel> quizzes;
  List<ResourceModel> resources;
  List<AssignmentModel> assignments;
  List<AttendanceModel> attendance;
  DateTime? startDate;

  ClassModel({
    this.id = "<!id>",
    this.semesterId,
    this.teacherIDs = const [],
    this.syllabus = "<!syllabus>",
    this.studentList = const [],
    this.ta = const [],
    this.channel,
    this.announcement = const [],
    this.quizzes = const [],
    this.resources = const [],
    this.assignments = const [],
    this.attendance = const [],
    this.startDate,
  });

  ClassModel copyWith({
    String? id,
    SemesterModel? semesterId,
    List<UserModel>? teacherIDs,
    String? syllabus,
    List<UserModel>? studentList,
    List<UserModel>? ta,
    ChannelModel? channel,
    List<AnnouncementModel>? announcement,
    List<QuizModel>? quizzes,
    List<ResourceModel>? resources,
    List<AssignmentModel>? assignments,
    List<AttendanceModel>? attendance,
    DateTime? startDate,
  }) =>
      ClassModel(
          id: id ?? this.id,
          semesterId: semesterId ?? this.semesterId ?? SemesterModel(),
          teacherIDs: teacherIDs ?? this.teacherIDs,
          syllabus: syllabus ?? this.syllabus,
          studentList: studentList ?? this.studentList,
          ta: ta ?? this.ta,
          channel: channel ?? this.channel ?? ChannelModel(),
          announcement: announcement ?? this.announcement,
          quizzes: quizzes ?? this.quizzes,
          resources: resources ?? this.resources,
          assignments: assignments ?? this.assignments,
          attendance: attendance ?? this.attendance,
          startDate: startDate ??
              this.startDate ??
              DateTime(2000, 2, 15, 00, 00, 00, 00, 00));

//TODO: NULL CHECKS
  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        id: json["_id"] ?? "<!id>",
        semesterId: json["semesterID"] == null
            ? SemesterModel()
            : SemesterModel.fromJson(json["semesterID"]),
        teacherIDs: json["teacherIDs"] == null
            ? []
            : List<UserModel>.from(
                json["teacherIDs"].map((x) => UserModel.fromJson(x))),
        syllabus: json["syllabus"] ?? "<!syllabus>",
        studentList: json["studentList"] == null
            ? []
            : List<UserModel>.from(
                json["studentList"].map((x) => UserModel.fromJson(x))),
        ta: json["TA"] == null
            ? []
            : List<UserModel>.from(
                json["TA"].map((x) => UserModel.fromJson(x))),
        channel: json["Channel"] == null
            ? ChannelModel()
            : ChannelModel.fromJson(json["Channel"]),
        announcement: json["Announcement"] == null
            ? []
            : List<AnnouncementModel>.from(
                json["Announcement"].map((x) => AnnouncementModel.fromJson(x))),
        quizzes: json["Quizzes"] == null
            ? []
            : List<QuizModel>.from(
                json["Quizzes"].map((x) => QuizModel.fromJson(x))),
        resources: json["Resources"] == null
            ? []
            : List<ResourceModel>.from(
                json["Resources"].map((x) => ResourceModel.fromJson(x))),
        assignments: json["Assignments"] == null
            ? []
            : List<AssignmentModel>.from(
                json["Assignments"].map((x) => AssignmentModel.fromJson(x))),
        attendance: json["Attendance"] == null
            ? []
            : List<AttendanceModel>.from(
                json["Attendance"].map((x) => AttendanceModel.fromJson(x))),
        startDate: json["startDate"] == null
            ? DateTime(2000, 2, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["startDate"]),
      );

  //TODO: NULL CHECKS
  Map<String, dynamic> toJson() => {
        "_id": id,
        "semesterID": semesterId == null ? null : semesterId!.toJson(),
        "teacherIDs": List<dynamic>.from(teacherIDs.map((x) => x.toJson())),
        "syllabus": syllabus,
        "studentList": List<dynamic>.from(studentList.map((x) => x.toJson())),
        "TA": List<dynamic>.from(ta.map((x) => x.toJson())),
        "Channel": channel == null ? null : channel!.toJson(),
        "Announcement": List<dynamic>.from(announcement.map((x) => x.toJson())),
        "Quizzes": List<dynamic>.from(quizzes.map((x) => x.toJson())),
        "Resources": List<dynamic>.from(resources.map((x) => x.toJson())),
        "Assignments": List<dynamic>.from(assignments.map((x) => x.toJson())),
        "Attendance": List<dynamic>.from(attendance.map((x) => x.toJson())),
        "startDate": startDate == null ? null : startDate!.toIso8601String(),
      };
}
