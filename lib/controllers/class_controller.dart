import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:front_end/models/class_model.dart';

import '../constants/log.dart';

class ClassController extends ChangeNotifier {
  final secureStorage = SecureStorage();
  ClassModel? myClass;

  ClassModel? get getMyClass => myClass;

  Future<void> getClassDetails(String id) async {
    try {
      // final test = jsonEncode(<String, String>{"classID": id});
      final token = await secureStorage.getToken();
      // print('testing: $test');
      final response = await http.post(
        Uri.parse('${Environment.baseURL}class/getclassDetailsShaheer'),
        headers: <String, String>{'Authorization': token ?? ""},
        body: <String, String>{"classID": id},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        Log.i('Response: ${response.statusCode}: ${response.body}');

        final courseDetails = responseData['classDetails']['course'];
        final teacherDetails = responseData['classDetails']['teacher'];
        final classDetails = responseData['classDetails']['class'];
        final channelDetails = responseData['channel'];
        final assignmentDetails = responseData['latestAssignment'];

        assignmentDetails.remove("submissions");

        Log.d("Assignment Details: $assignmentDetails");

        final announcementDetails = responseData["latestAnnouncement"];

        final filteredData = {
          "course": courseDetails,
          "teacher": teacherDetails,
          "latestAnnouncement": announcementDetails,
          "latestAssignment": assignmentDetails,
          "channel": channelDetails,
        };

        filteredData.addAll(classDetails);

        // print('courseDetails: $courseDetails');
        // print('classDetails: $filteredData');
        // log('classDetails: $filteredData');

        myClass = ClassModel.fromJson(filteredData);
        myClass!.id = id;
        notifyListeners();
        //print("Assignment Details: " + assignmentDetails);
      }

      // print('response: ${response.statusCode}: ${response.body}');
    } catch (e) {
      print("Class details fetch me masla: $e");
    }
  }

  Future<void> getAllAnnouncements(String id) async {
    try {
      final token = await secureStorage.getToken();
      final response = http.get(
        Uri.parse(
            '${Environment.baseURL}announcement/getAllClassAnnouncements/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
      );
      // if(response.statusCode == 200){
      //   final responseData = jsonDecode(response.body);
      //   print(responseData);
      // }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> updateSyllabus(String text) async {
    try {
      final token = await secureStorage.getToken();
      final response = await http.post(
        Uri.parse('${Environment.baseURL}class/uploadSyllabus'),
        headers: <String, String>{
          'Authorization': token ?? "",
          // "Content-Type": "application/json"
        },
        body: <String, String>{"classID": myClass!.id, "syllabus": text},
      );
      Log.e("classID: ${myClass!.id}, syllabus: $text");
      Log.e("Response: ${response.statusCode}: ${response.body}");
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        return true;
      }
    } catch (e) {
      // print(e.toString());
      Log.e(e.toString());
      return false;
    }
    return false;
  }
}
