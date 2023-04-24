import 'package:flutter/material.dart';
import 'package:front_end/entities/user_entity.dart';
import 'package:front_end/models/mock_data.dart';
import 'package:front_end/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserEntity user = UserEntity(
    fullName: "",
    ERP: "",
    email: "",
    profilePic: "",
    phoneNumber: "",
    CGPA: 0,
    program: "",
    courses: [],
  );

  void loadUser() {
    UserModel userModel = UserModel.fromJson(userJSON);
  }
}
