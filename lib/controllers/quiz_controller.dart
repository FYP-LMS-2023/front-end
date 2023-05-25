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

  String? quizID;
  String? get getQuizID => quizID;

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
                dueDate: DateTime.parse(quiz['dueDate']),
                marks: quiz['marks'],
                status: quiz['status']))
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
        Uri.parse('${Environment.baseURL}quiz/getQuizDetailsStudent/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Log.d(data);
        data.remove('classId');
        data.remove('submissions');
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
      Log.d(encodedData);
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
      final respStr = await response.stream.bytesToString();
      Log.e(respStr);
      // final response = await http.post(
      //   Uri.parse('${Environment.baseURL}quiz/submitQuiz'),
      //   headers: <String, String>{
      //     'Authorization': token ?? "",
      //     'Content-Type': 'application/json'
      //   },
      //   body: encodedData,
      // );

      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);
        Log.d(request.body);

        print(await response.stream.bytesToString());

        notifyListeners();
      } else {
        Log.e(
            "Submit quiz request failed with status code ${response.statusCode} + ${response.reasonPhrase}");
      }
    } catch (e) {
      Log.e("Error: $e");
    }
  }

  Future<String> createQuiz(Map<String, dynamic> data) async {
    Log.e(data);
    try {
      final token = await secureStorage.getToken();
      var headers = {
        'Authorization': token ?? "",
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST', Uri.parse('${Environment.baseURL}quiz/createQuiz'));

      request.body = json.encode({
        "title": data["title"],
        "description": data["description"],
        "startDate": data["startDate"],
        "dueDate": data["dueDate"],
        "classId": data["classID"],
        "status": data["status"],
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        var responseJson = await response.stream.bytesToString();
        var responseData = json.decode(responseJson);
        return responseData['_id'];
        // return;
      } else {
        // print(response.reasonPhrase);
        print(await response.stream.bytesToString());

        return '1';
      }
    } catch (e) {
      Log.e("Error: $e");
      return '1';
    }
  }

  Future<String> createQuestion(Map<String, dynamic> questionData) async {
    try {
      final token = await secureStorage.getToken();

      var headers = {
        'Authorization': token ?? '',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST', Uri.parse('${Environment.baseURL}question/createQuestion'));
      request.body = json.encode({
        "questionDescription": questionData["questionDescription"],
        "marks": questionData["marks"],
        "quizID": questionData["quizID"],
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        var responseJson = await response.stream.bytesToString();
        var responseData = json.decode(responseJson);
        return responseData['questionID'];
      } else {
        print(await response.stream.bytesToString());
        print(response.reasonPhrase);
        return '1';
      }
    } catch (e) {
      Log.e("Error: $e");
      return '1';
    }
  }

  Future<bool> createAnswer(Map<String, dynamic> data) async {
    try {
      final token = await secureStorage.getToken();
      var headers = {
        'Authorization': token ?? '',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST', Uri.parse('${Environment.baseURL}answer/createAnswer'));
      request.body = json.encode({
        "QuestionId": data["questionID"],
        "answerDescription": data["answerDescription"],
        "correctAnswer": data["correctAnswer"],
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(await response.stream.bytesToString());
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      Log.e("Error: $e");
      return false;
    }
  }
}
