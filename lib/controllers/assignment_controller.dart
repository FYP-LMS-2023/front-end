import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:front_end/models/assignment_submission_model.dart';
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

  int? numSubs;
  int? get getNumSubs => numSubs;

  List<AssignmentSubmissionModel>? submissions;
  List<AssignmentSubmissionModel>? get getSubmissions => submissions;

  Future<bool> resubmitAssignment(
      String id, Map<String, dynamic> data, List<File>? files) async {
    try {
      final token = await secureStorage.getToken();
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${Environment.baseURL}assignmentTwo/resubmitAssignment/$id'),
      );
      request.headers['Authorization'] = token ?? '';
      request.fields['submissionDescription'] =
          data['submissionDescription'] ?? '';

      Log.d("Submission Description: ${data['submissionDescription']}");

      for (File f in files!) {
        final mimeTypeData =
            lookupMimeType(f.path, headerBytes: [0xFF, 0xD8])?.split('/');
        final file = await http.MultipartFile.fromPath("files", f.path,
            contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));

        request.files.add(file);
      }

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
      Log.e("Error in resubmitAssignment: $e");
    }
    return false;
  }

  Future<bool> submitAsssignment(
      String id, Map<String, dynamic> data, List<File>? files) async {
    try {
      final token = await secureStorage.getToken();
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${Environment.baseURL}assignmentTwo/submitAssignment/$id'),
      );
      request.headers['Authorization'] = token ?? '';
      request.fields['submissionDescription'] =
          data['submissionDescription'] ?? '';

      Log.d("Submission Description: ${data['submissionDescription']}");

      for (File f in files!) {
        final mimeTypeData =
            lookupMimeType(f.path, headerBytes: [0xFF, 0xD8])?.split('/');
        final file = await http.MultipartFile.fromPath("files", f.path,
            contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));

        request.files.add(file);
      }

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
      Log.e("Error in submitAsssignment: $e");
    }
    return false;
  }

  Future<void> getAssignmentDetails(String id) async {
    try {
      final token = await secureStorage.getToken();
      print("wtf: $id");
      final response = await http.get(
        Uri.parse(
            '${Environment.baseURL}assignmentTwo/getAssignmentDetailsStudent/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
      );

      Log.d("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final assignmentData = responseData["assignment"];
        final submissionData = responseData["mySubmission"];
        if (submissionData != null) {
          submissionData.remove("studentID");
        }

        var temp = responseData["isSubmitted"];
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
          //var submissions = assignmentData["submissions"];
          var mySubmission = submissionData;
          var isSubmitted = temp;

          final filteredData = {
            "_id": id,
            "uploadDate": uploadDate,
            "dueDate": dueDate,
            "title": title,
            "status": status,
            "description": description,
            "marks": marks,
            "files": files,
            "mySubmission": mySubmission,
            "isSubmitted": isSubmitted,
            //"submissions": submissions,
          };
          Log.d(filteredData);
          Log.d("filteredData type: ${filteredData.runtimeType}");

          assignmentObject = AssignmentModel.fromJson(filteredData);
        }
        notifyListeners();
      }
    } catch (e) {
      Log.d("Error coming in get Assignment Details: $e");
    }
  }

  Future<void> getAllAssignments(String id) async {
    try {
      final token = await secureStorage.getToken();
      print('testing: $id');
      final response = await http.get(
        Uri.parse(
            '${Environment.baseURL}assignmentTwo/getAllClassAssignmentsStudent/$id'),
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
            // var temp = data["assignment"];
            Log.d("Data: $data");
            var id = data["_id"];
            var title = data["title"];
            var description = data["description"];
            var dueDate = data["dueDate"];
            var status = data["status"];
            var marks = data["marks"];
            var isSubmitted = data["isSubmitted"];
            var returned = data["returned"];

            final filteredData = {
              "_id": id,
              "title": title,
              "description": description,
              "dueDate": dueDate,
              "status": status,
              "marks": marks,
              "isSubmitted": isSubmitted,
              "returned": returned,
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

  Future<void> getAssignmentDetailsFaculty(String id) async {
    try {
      final token = await secureStorage.getToken();
      print("wtf: $id");
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
            // "submissions": submissions,
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

  Future<bool> udpateAssignment(Map<String, dynamic> data, String id) async {
    try {
      final token = await secureStorage.getToken();
      final response = await http.patch(
        Uri.parse('${Environment.baseURL}assignmentTwo/updateAssignment/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
        body: data,
      );

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
    } catch (e) {
      Log.e(e.toString());
    }
    return false;
  }

  Future<bool> deleteFile(int index, String id) async {
    try {
      final token = await secureStorage.getToken();

      final response = await http.patch(
        Uri.parse(
            '${Environment.baseURL}assignmentTwo/removeFileByIndexFromAssignment/$id/$index'),
        headers: <String, String>{'Authorization': token ?? ""},
      );

      Log.i(
        'Response Status Code: ${response.statusCode} - ${response.reasonPhrase}',
      );
      if (response.statusCode != 200) {
        Log.e("Error: ${response.body}");
        return false;
      } else {
        Log.v("Response: ${response.body}");
        return true;
      }
    } catch (e) {
      Log.e(e.toString());
      return false;
    }
  }

  Future<bool> addFile(List<File>? files, String id) async {
    try {
      final token = await secureStorage.getToken();
      var request = http.MultipartRequest(
          'PATCH',
          Uri.parse(
              '${Environment.baseURL}assignmentTwo/addFileToAssignment/$id'));

      request.headers['Authorization'] = token ?? '';

      for (File f in files!) {
        final mimeTypeData =
            lookupMimeType(f.path, headerBytes: [0xFF, 0xD8])?.split('/');
        final file = await http.MultipartFile.fromPath("files", f.path,
            contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));

        request.files.add(file);
      }

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

  Future<void> getNumSubmissions(String id) async {
    //this is probably the worst thing i could make
    //but im doing it for science
    //and i dont want to have intense merge conflicts
    //so literally bhaar mein jae
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

          numSubs = assignmentData["submissions"].length;
        }
        notifyListeners();
      }
    } catch (e) {
      print("Error coming: $e");
    }
  }

  Future<void> getAllSubmissions(String id) async {
    try {
      final token = await secureStorage.getToken();
      final response = await http.get(
        Uri.parse(
            '${Environment.baseURL}assignmentTwo/getAssignmentSubmissionsFac/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
      );

      Log.d("Response Status Code: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Log.w(responseData);
        final submissionData = responseData["submissions"];
        Log.d("Assignment Data: $submissionData");
        Log.d("Assignment Data is not Empty: ${submissionData.isNotEmpty}");

        if (submissionData.isNotEmpty) {
          Log.d("Data: $submissionData");

          List<AssignmentSubmissionModel> temp = [];
          for (var sub in submissionData) {
            temp.add(AssignmentSubmissionModel.fromJson(sub));
          }
          submissions = temp;
          Log.e(submissions);
        }
        notifyListeners();
      }
    } catch (e) {
      print("Error coming: $e");
    }
  }

  Future<bool> gradeAssignment(String id, int marks, String returnDesc) async {
    try {
      final token = await secureStorage.getToken();

      var headers = {
        'Authorization': token ?? "",
        'Content-Type': 'application/json'
      };
      var request = http.Request(
        'POST',
        Uri.parse(
            '${Environment.baseURL}assignmentTwo/gradeAssignmentSubmission/$id'),
      );
      request.body = json.encode({
        "marksReceived": marks,
        "returnDescription": returnDesc,
      });
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
      Log.e(e.toString());
      return false;
    }
  }

  Future<bool> deleteAssignment(String id) async {
    try {
      final token = await secureStorage.getToken();
      var headers = {
        'Authorization': token ?? "",
      };
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(
            '${Environment.baseURL}assignmentTwo/setAssignmentDeleteFlag/$id'),
      );
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
      Log.e(e.toString());
      return false;
    }
  }
}
