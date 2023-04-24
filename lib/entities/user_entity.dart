class UserEntity {
  String fullName;
  String ERP;
  String email;
  String profilePic;
  String phoneNumber;
  double CGPA;
  String program;
  List<Map<String, dynamic>>? courses;

  UserEntity({
    required this.fullName,
    required this.ERP,
    required this.email,
    required this.profilePic,
    required this.phoneNumber,
    required this.CGPA,
    required this.program,
    this.courses,
  });
}
