import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/log.dart';
import '../models/channel_model.dart';
import '../models/thread_model.dart';

class ReplyController extends ChangeNotifier {
  final secureStorage = SecureStorage();

  Future<void> createReply(String id,String content) async {
    try {
      final token = await secureStorage.getToken();
      final requestBody = {
        'reply': content,
      };
      Log.d("Comment Id: $id");
      final encodedBody = jsonEncode(requestBody);

      Log.d('Request Body: $encodedBody'); // Add this line to inspect the encoded request body content

      final response = await http.post(
        Uri.parse('${Environment.baseURL}channel/replyToComment/$id'),
        headers: <String, String>{
          'Authorization': token ?? "",
          'Content-Type': 'application/json',
        },
        body: encodedBody,
      );

      Log.d("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final repliesData = responseData["result"];
        Log.d("Replies Data: $repliesData");
        Log.d("Replies Data is not Empty: ${repliesData.isNotEmpty}");

        notifyListeners();
      }
    } catch (e) {
      Log.e('Error: $e');
    }
  }

  Future<void> upvoteReply(String id) async {
    try {
      final token = await secureStorage.getToken();
      Log.d("Reply Id received for upvote reply: $id");
      final response = await http.post(
        Uri.parse('${Environment.baseURL}channel/upvoteReply/$id'),
        headers: <String, String>{
          'Authorization': token ?? "",
          'Content-Type': 'application/json',
        },
      );
      Log.d("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final repliesData = responseData["reply"];
        Log.d("Replies Data: $repliesData");
        Log.d("Upvote Reply Successful");

        notifyListeners();
      }
    } catch (e) {
      Log.e('Error coming in upvote reply: $e');
    }
  }

  Future<void> downvoteReply(String id) async {
    try {
      final token = await secureStorage.getToken();
      Log.d("Reply Id received for downvote reply: $id");
      final response = await http.post(
        Uri.parse('${Environment.baseURL}channel/downvoteReply/$id'),
        headers: <String, String>{
          'Authorization': token ?? "",
          'Content-Type': 'application/json',
        },
      );
      Log.d("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final repliesData = responseData["reply"];
        Log.d("Replies Data: $repliesData");
        Log.d("Downvote Reply Successful");

        notifyListeners();
      }
    } catch (e) {
      Log.e('Error coming in downvote reply: $e');
    }
  }
}
