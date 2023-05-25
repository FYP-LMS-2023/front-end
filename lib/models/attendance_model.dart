import 'package:front_end/models/user_model.dart';

class AttendanceModel {
  String id;
  List<Session> sessions;

  AttendanceModel({
    this.id = "<!id>",
    this.sessions = const [],
  });

  AttendanceModel copyWith({
    String? id,
    List<Session>? sessions,
  }) =>
      AttendanceModel(
        id: id ?? this.id,
        sessions: sessions ?? this.sessions,
      );

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        id: json["_id"] ?? "<!id>",
        sessions: json["sessions"] == null
            ? []
            : List<Session>.from(
                json["sessions"].map((x) => Session.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sessions": List<dynamic>.from(sessions.map((x) => x.toJson())),
      };
}

class Session {
  String id;
  DateTime? date;
  List<Attendance> attendance;

  Session({
    this.id = "<!id>",
    this.date,
    this.attendance = const [],
  });

  Session copyWith({
    String? id,
    DateTime? date,
    List<Attendance>? attendance,
  }) =>
      Session(
        id: id ?? this.id,
        date: date ?? this.date ?? DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
        attendance: attendance ?? this.attendance,
      );

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["_id"] ?? "<!id>",
        date: json["date"] == null
            ? DateTime(2000, 2, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["date"]),
        attendance: json["attendance"] == null
            ? []
            : List<Attendance>.from(
                json["attendance"].map((x) => Attendance.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "date": date == null ? null : date!.toIso8601String(),
        "attendance": List<dynamic>.from(attendance.map((x) => x.toJson())),
      };
}

//* WILL HAVE TO APPLY NULL CHECK TO THE PRESENT VALUE IN UI TO CHECK IF THE VALUE HAS BEEN RETURNED BY THE API OR NOT
class Attendance {
  String id;
  UserModel? studentId;
  bool? present;

  Attendance({
    this.id = "<!id>",
    this.studentId,
    this.present,
  });

  Attendance copyWith({
    String? id,
    UserModel? studentId,
    bool? present,
  }) =>
      Attendance(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId ?? UserModel(),
        present: present ?? this.present,
      );

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        id: json["_id"] ?? "<!id>",
        studentId: json["studentID"] != null
            ? UserModel.fromJson(json["studentID"])
            : UserModel(),
        present: json["present"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "studentID": studentId == null ? null : studentId!.toJson(),
        "present": present,
      };
}

class AbsentDays {
  List<String> absentDays;
  int absentCount;

  AbsentDays({this.absentDays = const [], this.absentCount = -1});

  AbsentDays copyWith({List<String>? absentDays, int? absentCount}) =>
      AbsentDays(
        absentDays: absentDays ?? this.absentDays,
        absentCount: absentCount ?? this.absentCount,
      );

  factory AbsentDays.fromJson(Map<String, dynamic> json) => AbsentDays(
      absentDays: List<String>.from(
          json['absentDays']), //json["absentDays"] ?? "<!absentDays>",
      absentCount: json["absentCount"] ?? -1);

  Map<String, dynamic> toJson() => {
        "absentDays": List<String>.from(absentDays.map((x) => x)),
        "absentCount": absentCount
      };
}
