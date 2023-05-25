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

  AttendanceModel? classAttendance;
  AttendanceModel? get getClassAttendance => classAttendance;

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

  Future<void> loadAttendance(String id) async {
    try {
      final token = await secureStorage.getToken();

      final response = await http.get(
        Uri.parse('${Environment.baseURL}attendance/getAttendanceOfClass/$id'),
        headers: <String, String>{
          'Authorization': token ?? '',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Log.i(responseData);
        final classAttendanceData = responseData['returnAttendance'];
        Log.i(classAttendanceData);
        final filteredData = {"sessions": classAttendanceData};

        classAttendance = AttendanceModel.fromJson(filteredData);

        for (var c in classAttendance!.sessions) {
          Log.i(c);
        }

        notifyListeners();
        // attendanceModel = AttendanceModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      Log.d("Error: $e");
    }
  }

  Future<bool> toggleAttendance(Map<String, dynamic> data) async {
    Log.i("Toggle Attendance is being run");
    Log.i("Data: $data");
    try {
      final token = await secureStorage.getToken();
      var headers = {
        'Authorization': token ?? '',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
        'POST',
        Uri.parse('${Environment.baseURL}attendance/toggleAttendance'),
      );
      request.body = json.encode({
        "classID": data['classID'],
        "studentID": data['studentID'],
        "date": data['date'].toIso8601String(),
      });

      // request.body = json.encode(data);
      // for (var d in data) {
      //   request.body = json.encode(d);
      //   request.headers.addAll(headers);

      //   http.StreamedResponse response = await request.send();

      //   if (response.statusCode == 200) {
      //     print(await response.stream.bytesToString());
      //     // return true;
      //   } else {
      //     print(response.reasonPhrase);
      //     return false;
      //   }
      // }
      // return true;

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      Log.e("Error: $e");
      return false;
    }
  }
}
