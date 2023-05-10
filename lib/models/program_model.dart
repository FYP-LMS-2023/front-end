import 'package:front_end/models/course_model.dart';
import 'package:front_end/models/user_model.dart';

class ProgramModel {
  String id;
  String name;
  String code;
  String description;
  List<CourseModel> electives;
  List<CourseModel> cores;
  List<UserModel> faculty;

  ProgramModel({
    this.id = "<!id>",
    this.name = "<!name>",
    this.code = "<!code>",
    this.description = "<!description>",
    this.electives = const [],
    this.cores = const [],
    this.faculty = const [],
  });

  ProgramModel copyWith({
    String? id,
    String? name,
    String? code,
    String? description,
    List<CourseModel>? electives,
    List<CourseModel>? cores,
    List<UserModel>? faculty,
  }) =>
      ProgramModel(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        description: description ?? this.description,
        electives: electives ?? this.electives,
        cores: cores ?? this.cores,
        faculty: faculty ?? this.faculty,
      );

  factory ProgramModel.fromJson(Map<String, dynamic> json) => ProgramModel(
        id: json["_id"] ?? "<!id>",
        name: json["name"] ?? "<!name>",
        code: json["code"] ?? "<!code>",
        description: json["description"] ?? "<!description>",
        electives: json["electives"] != null
            ? List<CourseModel>.from(
                json["electives"].map((x) => CourseModel.fromJson(x)))
            : [],
        cores: json["cores"] != null
            ? List<CourseModel>.from(
                json["cores"].map((x) => CourseModel.fromJson(x)))
            : [],
        faculty: json["faculty"] != null
            ? List<UserModel>.from(
                json["faculty"].map((x) => UserModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "code": code,
        "description": description,
        // "electives": List<dynamic>.from(electives.map((x) => x)),
        "electives": List<dynamic>.from(electives.map((x) => x)),
        "cores": List<dynamic>.from(cores.map((x) => x)),
        "faculty": List<dynamic>.from(faculty.map((x) => x)),
      };
}
