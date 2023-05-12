import 'package:front_end/models/announcement_model.dart';
import 'package:front_end/models/assignment_model.dart';
import 'package:front_end/models/attendance_model.dart';
import 'package:front_end/models/channel_model.dart';
import 'package:front_end/models/course_model.dart';
import 'package:front_end/models/quiz_model.dart';
import 'package:front_end/models/resource_model.dart';
import 'package:front_end/models/semester_model.dart';
import 'package:front_end/models/user_model.dart';

class ClassModel {
  String id;
  // SemesterModel? semesterId;
  CourseModel? course;
  // List<UserModel> teacher;
  UserModel? teacher;
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
  //AssignmentModel? latestAssignment;
  //AnnouncementModel? latestAnnouncement;

  ClassModel({
    this.id = "<!id>",
    // this.semesterId,
    this.course,
    // this.teacher = const [],
    this.teacher,
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
    //this.latestAssignment,
    //this.latestAnnouncement,
  });

  ClassModel copyWith({
    String? id,
    // SemesterModel? semesterId,
    CourseModel? course,
    // List<UserModel>? teacherIDs,
    UserModel? teacher,
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
          // semesterId: semesterId ?? this.semesterId ?? SemesterModel(),
          course: course ?? this.course ?? CourseModel(),
          // teacher: teacherIDs ?? this.teacher,
          teacher: teacher ?? this.teacher ?? UserModel(),
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
        // semesterId: json["semesterID"] == null
        //     ? SemesterModel()
        //     : SemesterModel.fromJson(json["semesterID"]),
        course: json["course"] == null
            ? CourseModel()
            : CourseModel.fromJson(json["course"]),
        // // teacher: json["teacherIDs"] == null
        // //     ? []
        // //     : List<UserModel>.from(
        // //         json["teacherIDs"].map((x) => UserModel.fromJson(x))),
        teacher: json["teacher"] == null
            ? UserModel()
            : UserModel.fromJson(json["teacher"]),
        syllabus: json["syllabus"] ?? "<!syllabus>",
        studentList: json["student_list"] == null
            ? []
            : List<UserModel>.from(
                json["student_list"].map((x) => UserModel.fromJson(x))),
        ta: json["TA"] == null
            ? []
            : List<UserModel>.from(
                json["TA"].map((x) => UserModel.fromJson(x))),
        channel: json["channel"] == null
            ? ChannelModel()
            : ChannelModel.fromJson(json["channel"]),
        announcement: json["announcements"] == null
            ? []
            : List<AnnouncementModel>.from(
                json["announcements"].map((x) => AnnouncementModel.fromJson(x))),
        quizzes: json["quizzes"] == null
            ? []
            : List<QuizModel>.from(
                json["quizzes"].map((x) => QuizModel.fromJson(x))),
        resources: json["resources"] == null
            ? []
            : List<ResourceModel>.from(
                json["resources"].map((x) => ResourceModel.fromJson(x))),
        assignments: json["assignments"] == null
            ? []
            : List<AssignmentModel>.from(
                json["assignments"].map((x) => AssignmentModel.fromJson(x))),
        attendance: json["attendance"] == null
            ? []
            : List<AttendanceModel>.from(
                json["attendance"].map((x) => AttendanceModel.fromJson(x))),
        startDate: json["startDate"] == null
            ? DateTime(2000, 2, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["startDate"]),
        // latestAssignment: json["latestAssignment"] == null
        //     ? AssignmentModel()
        //     : AssignmentModel.fromJson(json["latestAssignment"]),
        // latestAnnouncement: json["latestAnnouncement"] == null
        //     ? AnnouncementModel()
        //     : AnnouncementModel.fromJson(json["latestAnnouncement"]),
      );

  //TODO: NULL CHECKS
  Map<String, dynamic> toJson() => {
        "_id": id,
        // "semesterID": semesterId == null ? null : semesterId!.toJson(),
        "course": course == null ? null : course!.toJson(),
        // "teacherIDs": List<dynamic>.from(teacher.map((x) => x.toJson())),
        "teacher": teacher == null ? null : teacher!.toJson(),
        "syllabus": syllabus,
        "student_list": List<dynamic>.from(studentList.map((x) => x.toJson())),
        "TA": List<dynamic>.from(ta.map((x) => x.toJson())),
        "channel": channel == null ? null : channel!.toJson(),
        "announcements": List<dynamic>.from(announcement.map((x) => x.toJson())),
        "quizzes": List<dynamic>.from(quizzes.map((x) => x.toJson())),
        "resources": List<dynamic>.from(resources.map((x) => x.toJson())),
        "assignments": List<dynamic>.from(assignments.map((x) => x.toJson())),
        "attendance": List<dynamic>.from(attendance.map((x) => x.toJson())),
        "startDate": startDate == null ? null : startDate!.toIso8601String(),
      };
}
