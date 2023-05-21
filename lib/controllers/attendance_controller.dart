import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:front_end/models/attendance_model.dart';
import 'package:http/http.dart' as http;

import '../constants/log.dart';

class AttendanceController extends ChangeNotifier {
  final secureStorage = SecureStorage();

  AbsentDays? attendance;

  AbsentDays? get getAttendance => attendance;

  Future<void> getMyAttendance(String id) async {
    try {
      final token = await secureStorage.getToken();

      final response = await http.get(
        Uri.parse(
            '${Environment.baseURL}attendance/getMyAttendanceOfClass/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
      );

      Log.e(jsonDecode(response.body));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        attendance = AbsentDays.fromJson(responseData);

        Log.e(responseData);
        
        notifyListeners();
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
