import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:front_end/models/user_model.dart';
import 'package:http/http.dart' as http;

import '../constants/log.dart';

class UserController extends ChangeNotifier {
  UserModel? _user;
  int errorCode = 0;
  final secureStorage = SecureStorage();

  UserModel? get getUser => _user;
  int get getErrorCode => errorCode;

  Future<bool> login(String email, String password) async {
    try {
      // print(Constants.baseURL);
      final response = await http.post(
        Uri.parse('${Environment.baseURL}auth/login'),
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
        await secureStorage.setToken(responseData["token"]);
        await getUserInfo();

        notifyListeners();
        return true;
      } else if (response.statusCode == 401) {
        errorCode = 401;
        return false;
      } else if (response.statusCode == 403) {
        errorCode = 403;
        return false;
      } else {
        print('else: ${response.statusCode}: ${response.body}');
        return false;
      }
    } catch (e, s) {
      // print('<Error>: $e $s');
      Log.e('<Error>: $e $s');

      return false;
    }
  }

  Future<void> getUserInfo() async {
    try {
      final token = await secureStorage.getToken();
      final response = await http.get(
        Uri.parse("${Environment.baseURL}auth/getPopulatedProfile"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
      );

      final responseData = jsonDecode(response.body);
      // print(responseData);

      if (response.statusCode == 200) {
        Log.d("User info: ${responseData["user"]}");
        _user = UserModel.fromJson(responseData["user"]);

        notifyListeners();
      } else {
        Log.e('get error: ${response.statusCode}: ${response.body}');
        // throw Exception(responseData["message"]);
      }
    } catch (e) {
      print('get error: $e');
    }
  }
}
