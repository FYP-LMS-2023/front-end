import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/log.dart';
import '../models/assignment_model.dart';

class AssignmentController extends ChangeNotifier {
  final secureStorage = SecureStorage();

  List<AssignmentModel>? assignments;

  List<AssignmentModel>? get getAssignments=> assignments;

  Future<void> getAllAssignments(String id) async {
    try{ 
      final token = await secureStorage.getToken();
      // print('testing: $test');
      final response = await http.get(
        Uri.parse('${Environment.baseURL}assignmentTwo/getAllClassAssignments/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
        // body: <String, String>{"classID": id},
      );

      // Log.d("Response Status Code: ${response.statusCode}");

      if(response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final assignmentsData = responseData["assignments"] as List<dynamic>;
        Log.d("Assignments Data: $assignmentsData");
        Log.d("Assignments Data is not Empty: ${assignmentsData.isNotEmpty}");
        List<AssignmentModel> tempAssignments = [];

      if (assignmentsData.isNotEmpty) {
        tempAssignments = [];
        for (var data in assignmentsData) {
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
          tempAssignments.add(AssignmentModel.fromJson(filteredData));
        }

        Log.d("Temp Assignments: $tempAssignments");
        assignments = tempAssignments;
        notifyListeners();
      }
      }

    } catch(e){
      print("Widget ID: $id");
      print("Error agaya: $e");
    }
  }
}