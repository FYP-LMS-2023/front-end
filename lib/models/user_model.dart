import 'package:front_end/models/course_model.dart';
import 'package:front_end/models/program_model.dart';

class UserModel {
  String id;
  String fullName;
  String erp;
  String email;
  String userType;
  String profilePic;
  List<CourseModel> courses; //?
  String phoneNumber;
  double cgpa;
  ProgramModel? program;
  //TODO: Change to NotificationModel
  // List<String> notifications; //?

  UserModel({
    this.id = "<!id>",
    this.fullName = "<!fullName>",
    this.erp = "<!erp>",
    this.email = "<!email>",
    this.userType = "<!userType>",
    this.profilePic = "<!profilePic>",
    this.courses = const [],
    this.phoneNumber = "<!phoneNumber>",
    this.cgpa = -1,
    this.program,
    //TODO: Change to NotificationModel
    // this.notifications = const [],
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? erp,
    String? email,
    String? userType,
    String? profilePic,
    List<CourseModel>? courses,
    String? phoneNumber,
    double? cgpa,
    ProgramModel? program,
    //TODO: Change to NotificationModel
    // List<String>? notifications,
  }) =>
      UserModel(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        erp: erp ?? this.erp,
        email: email ?? this.email,
        userType: userType ?? this.userType,
        profilePic: profilePic ?? this.profilePic,
        courses: courses ?? this.courses,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        cgpa: cgpa ?? this.cgpa,
        program: program ?? this.program ?? ProgramModel(),
        // notifications: notifications ?? this.notifications,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // final json = res["user"];
    // print("UserModel.fromJson: $json");
    return UserModel(
      id: json["_id"] ?? "<!id>",
      fullName: json["fullName"] ?? "<!name>",
      erp: json["ERP"] ?? "<!erp>",
      email: json["email"] ?? "<!email>",
      userType: json["userType"] ?? "<!userType>",
      profilePic: json["profilePic"] ?? "<!profilePic>",
      courses: json["courses"] != null
          ? List<CourseModel>.from(
              json["courses"].map((x) => CourseModel.fromJson(x)))
          : [],
      phoneNumber: json["phoneNumber"] ?? "<!phoneNumber>",
      cgpa: json["CGPA"]?.toDouble() ?? -1,
      program: json["program"] != null
          ? ProgramModel.fromJson(json["program"])
          : ProgramModel(),

      //TODO: Change to NotificationModel
      // notifications: List<String>.from(json["notifications"].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "ERP": erp,
        "email": email,
        "userType": userType,
        "profilePic": profilePic,
        "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
        "phoneNumber": phoneNumber,
        "CGPA": cgpa,
        "program": program != null ? program!.toJson() : null,
        //TODO: Change to NotificationModel
        // "notifications": List<dynamic>.from(notifications.map((x) => x)),
      };
}
