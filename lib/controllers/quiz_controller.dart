import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/log.dart';
import '../models/quiz_model.dart';

class QuizController extends ChangeNotifier {
  final secureStorage = SecureStorage();

  List<QuizModel>? quizzes;

  List<QuizModel>? get getQuizzes => quizzes;

  Future<void> getAllQuizzes(String id) async {
    try {
      final token = await secureStorage.getToken();
      // print('testing: $test');
      final response = await http.get(
        Uri.parse('${Environment.baseURL}quiz/getQuiz/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
        // body: <String, String>{"classID": id},
      );

      // Log.d("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final quizzesData = responseData["quizzes"] as List<dynamic>;
        Log.d("Quizzes Data: $quizzesData");
        Log.d("Quizzes Data is not Empty: ${quizzesData.isNotEmpty}");
        List<QuizModel> tempQuizzes = [];

        if (quizzesData.isNotEmpty) {
          tempQuizzes = [];
          for (var data in quizzesData) {
            Log.d("Data: $data");
            var id = data["_id"];
            var title = data["title"];
            var description = data["description"];
            var uploadDate = data["uploadDate"];
            var dueDate = data["dueDate"];
            var startDate = data["startDate"];
            var classId = data["classId"];
            var status = data["status"];
            var submissions = data["submissions"];
            var questions = data["questions"];
            var marks = data["marks"];

            final filteredData = {
              "_id": id,
              "title": title,
              "description": description,
              "uploadDate": uploadDate,
              "dueDate": dueDate,
              "startDate": startDate,
              "classId": classId,
              "status": status,
              "submissions": submissions,
              "questions": questions,
              "marks": marks,
            };
            Log.d("filteredData: $filteredData");
            Log.d("filteredData type: ${filteredData.runtimeType}");
            tempQuizzes.add(QuizModel.fromJson(filteredData));
          }

          Log.d("Temp Assignments: $tempQuizzes");
          quizzes = tempQuizzes;
          notifyListeners();
        }
      }
    } catch (e) {
      print("Widget ID: $id");
      print("Error agaya: $e");
    }
  }
}
