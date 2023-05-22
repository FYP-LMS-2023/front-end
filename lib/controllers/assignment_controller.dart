import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import '../constants/log.dart';
import '../models/assignment_model.dart';

class AssignmentController extends ChangeNotifier {
  final secureStorage = SecureStorage();

  AssignmentModel? assignmentObject;

  AssignmentModel? get getAssignmentObject => assignmentObject;

  List<AssignmentModel>? assignments;

  List<AssignmentModel>? get getAssignments => assignments;

  Future<void> getAssignmentDetails(String id) async {
    try {
      final token = await secureStorage.getToken();
      final response = await http.get(
        Uri.parse('${Environment.baseURL}assignmentTwo/getAssignmentById/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
      );

      Log.d("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final assignmentData = responseData["assignment"];
        Log.d("Assignment Data: $assignmentData");
        Log.d("Assignment Data is not Empty: ${assignmentData.isNotEmpty}");

        if (assignmentData.isNotEmpty) {
          Log.d("Data: $assignmentData");
          var id = assignmentData["_id"];
          var uploadDate = assignmentData["uploadDate"];
          var dueDate = assignmentData["dueDate"];
          var title = assignmentData["title"];
          var status = assignmentData["status"];
          var description = assignmentData["description"];
          var marks = assignmentData["marks"];
          var files = assignmentData["files"];
          var submissions = assignmentData["submissions"];

          final filteredData = {
            "_id": id,
            "uploadDate": uploadDate,
            "dueDate": dueDate,
            "title": title,
            "status": status,
            "description": description,
            "marks": marks,
            "files": files,
            "submissions": submissions,
          };
          Log.d("filteredData: $filteredData");
          Log.d("filteredData type: ${filteredData.runtimeType}");

          assignmentObject = AssignmentModel.fromJson(filteredData);
        }
        notifyListeners();
      }
    } catch (e) {
      print("Error coming: $e");
    }
  }

  Future<void> getAllAssignments(String id) async {
    try {
      final token = await secureStorage.getToken();
      // print('testing: $test');
      final response = await http.get(
        Uri.parse(
            '${Environment.baseURL}assignmentTwo/getAllClassAssignments/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
        // body: <String, String>{"classID": id},
      );

      // Log.d("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
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
              "marks": marks,
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
    } catch (e) {
      print("Widget ID: $id");
      print("Error agaya: $e");
    }
  }

  Future<bool> createAssignment(
    Map<String, dynamic> data,
    List<File>? files,
  ) async {
    final token = await secureStorage.getToken();
    var request = http.MultipartRequest('POST',
        Uri.parse('${Environment.baseURL}assignmentTwo/createAssignment'));

    request.headers['Authorization'] = token ?? '';

    request.fields['classID'] = data['classID'];
    request.fields['title'] = data['title'];
    request.fields['description'] = data['description'];
    request.fields['dueDate'] = data['dueDate'];
    request.fields['marks'] = data['marks'];
    request.fields['status'] = data['status'];

    for (File f in files!) {
      final mimeTypeData =
          lookupMimeType(f.path, headerBytes: [0xFF, 0xD8])?.split('/');
      final file = await http.MultipartFile.fromPath("files", f.path,
          contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));

      request.files.add(file);
    }

    try {
      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      Log.i(
          'Response Status Code: ${response.statusCode} - ${response.reasonPhrase}');

      if (response.statusCode != 200) {
        Log.e("Error: ${response.body}");
        return false;
      } else {
        Log.v("Response: ${response.body}");
        return true;
      }
    } catch (e) {
      Log.e(e.toString());
    }
    return false;
  }
}
