import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/log.dart';
import '../models/channel_model.dart';
import '../models/thread_model.dart';

class ThreadController extends ChangeNotifier {
  final secureStorage = SecureStorage();

  Future<void> upvoteThread(String id) async {
    try {
      final token = await secureStorage.getToken();
      Log.d("Thread Id received for upvote thread: $id");
      final response = await http.post(
        Uri.parse('${Environment.baseURL}channel/upvoteThread/$id'),
        headers: <String, String>{
          'Authorization': token ?? "",
          'Content-Type': 'application/json',
        },
      );
      Log.d("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final threadsData = responseData["thread"];
        Log.d("Threads Data: $threadsData");
        Log.d("Upvote Thread Successful");

        notifyListeners();
      }
    } catch (e) {
      Log.e('Error coming in upvote thread: $e');
    }
  }

  Future<void> downvoteThread(String id) async {
    try {
      final token = await secureStorage.getToken();
      Log.d("Thread Id received for downvote thread: $id");
      final response = await http.post(
        Uri.parse('${Environment.baseURL}channel/downvoteThread/$id'),
        headers: <String, String>{
          'Authorization': token ?? "",
          'Content-Type': 'application/json',
        },
      );
      Log.d("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final threadsData = responseData["thread"];
        Log.d("Threads Data: $threadsData");
        Log.d("Downvote Thread Successful");

        notifyListeners();
      }
    } catch (e) {
      Log.e('Error coming in downvote thread: $e');
    }
  }
}
