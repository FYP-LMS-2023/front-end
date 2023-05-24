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
  QuizModel? quiz;
  QuizModel? get getCurrentQuiz => quiz;

  List<QuizModel>? get getQuizzes => quizzes;

  Future<void> getAllQuizzes(String id) async {
    try {
      final token = await secureStorage.getToken();
      final response = await http.get(
        Uri.parse('${Environment.baseURL}quiz/getQuizByClassID/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        quizzes = data
            .map((quiz) => QuizModel(
                id: quiz['_id'],
                title: quiz['title'],
                dueDate: DateTime.parse(quiz['dueDate'])))
            .toList();
        Log.e(quizzes);

        notifyListeners();
      }
    } catch (e) {
      print("Widget ID: $id");
      Log.e("Error: $e");
    }
  }

  Future<void> getCurrentQuizzes(String id) async {
    try {
      final token = await secureStorage.getToken();
      final response = await http.get(
        Uri.parse('${Environment.baseURL}quiz/getQuiz/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Log.d(data);
        data.remove('classId');
        quiz = QuizModel.fromJson(data);
        Log.e(quiz!.title);

        notifyListeners();
      }
    } catch (e) {
      print("Widget ID: $id");
      Log.e("Error: $e");
    }
  }

  Future<void> submitQuiz(Map<String, dynamic> data) async {
    try {
      final token = await secureStorage.getToken();
      final encodedData = jsonEncode(data);
      Log.e(encodedData);
      var headers = {
        "Authorization": token ?? "",
        "Content-Type": "application/json"
      };
      var request = http.Request(
          "POST", Uri.parse('${Environment.baseURL}quiz/submitQuiz'));

      request.body = jsonEncode({
        "submittedFor": data['submittedFor'],
        "submission": data['submission'],
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // final response = await http.post(
      //   Uri.parse('${Environment.baseURL}quiz/submitQuiz'),
      //   headers: <String, String>{
      //     'Authorization': token ?? "",
      //     'Content-Type': 'application/json'
      //   },
      //   body: encodedData,
      // );

      // Log.e(encodedData);
      // Log.d(response.statusCode);
      // Log.d(response.body);
      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);
        print(await response.stream.bytesToString());

        notifyListeners();
      } else {
        Log.e(
            "Submit quiz request failed with status code ${response.statusCode}");
      }
    } catch (e) {
      Log.e("Error: $e");
    }
  }
}
