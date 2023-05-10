class SemesterModel {
  String id;
  String semesterName;
  DateTime? semesterStartDate;
  DateTime? semesterEndDate;

  SemesterModel({
    this.id = "<!id>",
    this.semesterName = "<!semesterName>",
    this.semesterStartDate,
    this.semesterEndDate,
  });

  SemesterModel copyWith({
    String? id,
    String? semesterName,
    DateTime? semesterStartDate,
    DateTime? semesterEndDate,
  }) =>
      SemesterModel(
          id: id ?? this.id,
          semesterName: semesterName ?? this.semesterName,
          semesterStartDate: semesterStartDate ??
              this.semesterStartDate ??
              DateTime(2000, 2, 15, 00, 00, 00, 00, 00),
          semesterEndDate: semesterEndDate ??
              this.semesterEndDate ??
              DateTime(2000, 2, 15, 00, 00, 00, 00, 00));

  factory SemesterModel.fromJson(Map<String, dynamic> json) => SemesterModel(
        id: json["_id"] ?? "<!id>",
        semesterName: json["semesterName"] ?? "<!semesterName>",
        semesterStartDate: json["semesterStartDate"] == null
            ? DateTime(2000, 2, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["semesterStartDate"]),
        semesterEndDate: json["semesterEndDate"] == null
            ? DateTime(2000, 2, 15, 00, 00, 00, 00, 00)
            : DateTime.parse(json["semesterEndDate"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "semesterName": semesterName,
        "semesterStartDate": semesterStartDate == null
            ? null
            : semesterStartDate!.toIso8601String(),
        "semesterEndDate":
            semesterEndDate == null ? null : semesterEndDate!.toIso8601String(),
      };
}
