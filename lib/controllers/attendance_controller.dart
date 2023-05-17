import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:front_end/models/attendance_model.dart';
import 'package:http/http.dart' as http;

import '../constants/log.dart';
import '../models/assignment_model.dart';

class AttendanceController extends ChangeNotifier {
  final secureStorage = SecureStorage();

  List<AttendanceModel>? attendance;

  List<AttendanceModel>? get getAttendance=> attendance;

  Future<void> getAttendanceOfClass(String id) async {
    try{ 
      final token = await secureStorage.getToken();
      // print('testing: $test');
      final response = await http.get(
        Uri.parse('${Environment.baseURL}attendance/getAttendanceofClass/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
        // body: <String, String>{"classID": id},
      );

      // Log.d("Response Status Code: ${response.statusCode}");

      if(response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final attendanceData = responseData["attendance"] as List<dynamic>;
        Log.d("Attendance Data: $attendanceData");
        Log.d("Attendance Data is not Empty: ${attendanceData.isNotEmpty}");
        List<AttendanceModel> tempAttendance = [];

      if (attendanceData.isNotEmpty) {
        tempAttendance = [];
        for (var data in attendanceData) {
          Log.d("Data: $data");
          var id = data["_id"];
          var title = data["title"];
          var description = data["description"];
          var dueDate = data["dueDate"];
          var status = data["status"];
          var marks = data["marks"];

          final filteredData = {
            "_id": id,
            "title": title,
            "description": description,
            "dueDate": dueDate,
            "status": status,
            "marks" : marks,
          };
          Log.d("filteredData: $filteredData");
          Log.d("filteredData type: ${filteredData.runtimeType}");
          tempAttendance.add(AttendanceModel.fromJson(filteredData));
        }

        Log.d("Temp Assignments: $tempAttendance");
        attendance = tempAttendance;
        notifyListeners();
      }
      }

    } catch(e){
      print("Widget ID: $id");
      print("Error agaya: $e");
    }
  }
}