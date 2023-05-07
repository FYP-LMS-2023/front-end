import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:front_end/constants/constants.dart';
import 'package:front_end/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserController extends ChangeNotifier {
  UserModel? _user;
  String? token;
  bool? isAdmin;
  int error_code = 0;

  UserModel? get user => _user;
  bool? get userIsAdmin => isAdmin;
  int get errorCode => error_code;
  // String? get userToken => token;

  Future<bool> login(String email, String password) async {
    try {
      print(Constants.baseURL);
      final response = await http.post(
        Uri.parse('${Constants.baseURL}auth/login'),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          <String, String>{
            "email": email,
            "password": password,
          },
        ),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        token = responseData["token"];
        isAdmin = responseData["isAdmin"];
        await getUserInfo();

        notifyListeners();
        return true;
      } else if (response.statusCode == 401) {
        error_code = 401;
        return false;
      } else if (response.statusCode == 403) {
        error_code = 403;
        return false;
      } else {
        print('else: ${response.statusCode}: ${response.body}');
        return false;
        // throw Exception(responseData["message"]);
        // return false;
      }
    } catch (e) {
      print('<Error>: $e');
      return false;
      // throw e;
    }
  }

  Future<void> getUserInfo() async {
    try {
      final response = await http.get(
        Uri.parse("${Constants.baseURL}auth/getProfile"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
      );

      final responseData = jsonDecode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        _user = UserModel.fromJson(responseData["user"]);
        // _user?.copyWith(token: token);
        _user?.token = token!;
        // _user?.copyWith(token: token);
        // print(responseData);
        // print(_user?.token);

        notifyListeners();
      } else {
        throw Exception(responseData["message"]);
      }
    } catch (e) {
      // throw e;
      print('get error: $e');
    }
  }
}
