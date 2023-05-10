import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/course_model.dart';

class HomeProvider extends ChangeNotifier {
  List<CourseModel>? activeClasses;
  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDQ1NDU2NzliZTk2NTQ2MjI2ZDM5MTQiLCJlbWFpbCI6InN0dWQxQGdtYWlsLmNvbSIsIkVSUCI6IjAwMDAyIiwidXNlclR5cGUiOiJTdHVkZW50IiwiaWF0IjoxNjgzMjk5MTUwLCJleHAiOjE2ODMzODU1NTB9.abX1GH32kJ0PPlJw1yn1dqVm3TIFqTHIORhlSvkDGJQ";

  Future<void> getActiveCourses() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://smash-back-end-lms.vercel.app/general/getMainDashboard'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final activeCoursesData = jsonData['activeClasses'] as List<dynamic>;
        activeClasses = activeCoursesData
            .map((courseData) => CourseModel(
                courseName: courseData['courseName'],
                courseCode: courseData['courseCode']))
            .toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load active courses');
      }
    } catch (error) {
      print(error.toString());
      throw Exception('Failed to load active courses');
    }
  }
}
