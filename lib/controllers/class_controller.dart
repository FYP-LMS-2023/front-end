import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:front_end/models/class_model.dart';

import '../constants/log.dart';

class ClassController extends ChangeNotifier {
  final secureStorage = SecureStorage();
  ClassModel? myClass;
  ClassModel? mySyllabus;

  ClassModel? get getMyClass => myClass;
  ClassModel? get getSyllabus => mySyllabus;

  Future<void> getClassDetails(String id) async {
    try {
      // final test = jsonEncode(<String, String>{"classID": id});
      final token = await secureStorage.getToken();
      // print('testing: $test');
      final response = await http.post(
        Uri.parse('${Environment.baseURL}class/getClassDetailsShaheer'),
        headers: <String, String>{'Authorization': token ?? ""},
        body: <String, String>{"classID": id},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final courseDetails = responseData['classDetails']['course'];
        final teacherDetails = responseData['classDetails']['teacher'];
        final classDetails = responseData['classDetails']['class'];
        final channelDetails = responseData['channel'];
        final annoucementDetails = responseData['announcement'];
        // final syllabus = responseData['syllabus'];

        Log.v(responseData);

        final filteredData = {
          "course": courseDetails,
          "teacher": teacherDetails,
          // "classDetails": classDetails,
          // "channel": channelDetails,
          "announcements": annoucementDetails,
          //"syllabus": syllabus
        };

        filteredData.addAll(classDetails);

        // print('courseDetails: $courseDetails');
        // print('classDetails: $filteredData');
        // log('classDetails: $filteredData');
        Log.d('classDetails: $filteredData');
        myClass = ClassModel.fromJson(filteredData);

        // print(myClass!.course!.courseName);
        notifyListeners();
      }

      // print('response: ${response.statusCode}: ${response.body}');
    } catch (e) {
      print(e.toString());
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

  //   Future<void> getMySyllabus(String id) async {
  //   try {
  //     final token = await secureStorage.getToken();
  //     final response = http.get(
  //       Uri.parse(
  //           '${Environment.baseURL}class/getClassDetails/$id'),
  //       headers: <String, String>{'Authorization': token ?? ""},
  //     );

  //     if(response.statusCode == 200){
  //       final responseData = jsonDecode(response.body);
  //       print(responseData);
  //     }

  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
