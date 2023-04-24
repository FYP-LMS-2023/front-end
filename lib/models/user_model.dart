class UserModel {
  final String fullName;
  final String ERP;
  final String email;
  final String profilePic;
  final String phoneNumber;
  final double CGPA;
  final String program;
  List<Map<String, dynamic>>? courses;

  UserModel({
    required this.fullName,
    required this.ERP,
    required this.email,
    required this.profilePic,
    required this.phoneNumber,
    required this.CGPA,
    required this.program,
    this.courses,
  });

  static fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['full_name'],
      ERP: json['erp'],
      email: json['email'],
      profilePic: json['profile_pic'],
      phoneNumber: json['phone_number'],
      CGPA: json['cgpa'],
      program: json['program'],
      courses: json['courses'],
    );
  }

  toJson() {
    return {
      'full_name': fullName,
      'erp': ERP,
      'email': email,
      'profile_pic': profilePic,
      'phone_number': phoneNumber,
      'cgpa': CGPA,
      'program': program,
      'courses': courses,
    };
  }
}
