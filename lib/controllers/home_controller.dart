import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:front_end/models/announcement_model.dart';
import 'package:front_end/models/class_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/course_model.dart';

class HomeController extends ChangeNotifier {
  final secureStorage = SecureStorage();
  List<ClassModel>? activeClasses;
  List<AnnouncementModel>? announcements;

  List<ClassModel>? get getActiveClasses => activeClasses;
  List<AnnouncementModel>? get getAnnouncements => announcements;

  Future<void> getDashboard() async {
    try {
      final token = await secureStorage.getToken();
      final response = await http.get(
        Uri.parse('${Environment.baseURL}general/getMainDashboard'),
        headers: {'Authorization': token ?? ""},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        final activeClassData = jsonData['activeClasses'] as List<dynamic>;
        activeClasses = activeClassData
            .map((courseData) => ClassModel(
                id: courseData['_id'],
                course: CourseModel(
                    courseName: courseData['courseName'],
                    courseCode: courseData['courseCode'])))
            .toList();

        final announcementsData = jsonData['announcements'] as List<dynamic>;
        announcements = announcementsData
            .map((announcementData) => AnnouncementModel(
                  id: announcementData['_id'],
                  announcementType: announcementData['announcementType'],
                ))
            .toList();

        notifyListeners();
      } else {
        print('${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('hello: ${error.toString()}');
    }
  }

  Future<void> getFacultyDashboard() async {
    try {
      final token = await secureStorage.getToken();
      final response = await http.get(
        Uri.parse('${Environment.baseURL}class/getActiveClassesForTeacher'),
        headers: {'Authorization': token ?? ""},
      );
      // Log.i(response.body);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final activeClassData = jsonData['activeClasses'] as List<dynamic>;
        Log.d(activeClassData);
        activeClasses = activeClassData
            .map((courseData) => ClassModel(
                id: courseData['_id'],
                course: CourseModel(
                    courseCode: courseData['courseCode'],
                    courseName: courseData['courseName'])))
            .toList();

        notifyListeners();
        Log.i(jsonData);
      }
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }
}
