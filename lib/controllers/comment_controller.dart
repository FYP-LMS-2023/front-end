import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/log.dart';

class CommentController extends ChangeNotifier {
  final secureStorage = SecureStorage();

  Future<void> createComment(String id, String content) async {
    try {
      final token = await secureStorage.getToken();
      final requestBody = {
        'comment': content,
      };
      Log.d("Thread Id: $id");
      final encodedBody = jsonEncode(requestBody);

      Log.d('Request Body: $encodedBody'); // Add this line to inspect the encoded request body content

      final response = await http.post(
        Uri.parse('${Environment.baseURL}channel/createCommentOnThread/$id'),
        headers: <String, String>{
          'Authorization': token ?? "",
          'Content-Type': 'application/json',
        },
        body: encodedBody,
      );

      Log.d("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final commentsData = responseData["result"];
        Log.d("Comments Data: $commentsData");
        Log.d("Comments Data is not Empty: ${commentsData.isNotEmpty}");

        notifyListeners();
      }
    } catch (e) {
      Log.e('Error: $e');
    }
  }

  Future<void> upvoteComment(String id) async {
    try {
      final token = await secureStorage.getToken();
      Log.d("Comment Id received for upvote comment: $id");
      final response = await http.post(
        Uri.parse('${Environment.baseURL}channel/upvoteComment/$id'),
        headers: <String, String>{
          'Authorization': token ?? "",
          'Content-Type': 'application/json',
        },
      );
      Log.d("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final commentsData = responseData["comment"];
        Log.d("Comments Data: $commentsData");
        Log.d("Upvote Comment Successful");

        notifyListeners();
      }
    } catch (e) {
      Log.e('Error coming in upvote comment: $e');
    }
  }

  Future<void> downvoteComment(String id) async {
    try {
      final token = await secureStorage.getToken();
      Log.d("Comment Id received for downvote thread: $id");
      final response = await http.post(
        Uri.parse('${Environment.baseURL}channel/downvoteComment/$id'),
        headers: <String, String>{
          'Authorization': token ?? "",
          'Content-Type': 'application/json',
        },
      );
      Log.d("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final commentsData = responseData["comment"];
        Log.d("Comment Data: $commentsData");
        Log.d("Downvote Comment Successful");

        notifyListeners();
      }
    } catch (e) {
      Log.e('Error coming in downvote comment: $e');
    }
  }
}
