import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/log.dart';
import '../models/channel_model.dart';
import '../models/thread_model.dart';

class ChannelController extends ChangeNotifier {
  final secureStorage = SecureStorage();

  List<ThreadModel>? threads;

  List<ThreadModel>? get getThreads => threads;

  Future<void> getAllThreads(String id) async {
    try {
      final token = await secureStorage.getToken();
      final response = await http.get(
        Uri.parse('${Environment.baseURL}channel/getChannel/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
      );
      Log.d("Response Status Code: ${response.statusCode}");

      if(response.statusCode == 200) { 
        final responseData = jsonDecode(response.body);
        final threadsData = responseData["threads"] as List<dynamic>;
        Log.d("Threads Data: $threadsData");
        Log.d("Threads Data is not Empty: ${threadsData.isNotEmpty}");
        List<ThreadModel> tempThreads = [];
        
        if (threadsData.isNotEmpty) {
          tempThreads = [];
          for (var data in threadsData) {
            Log.d("Data: $data");
            var id = data["_id"];
            var postedBy = data["postedBy"];
            var title = data["title"];
            var description = data["description"];
            var comments = data["comments"];
            var tags = data["tags"];
            var upVotes = data["upVotes"];
            var downVotes = data["downVotes"];
            var datePosted = data["datePosted"];

            final filteredData = {
              "_id": id,
              "title": title,
              "description": description,
              "postedBy": postedBy,
              "comments": comments,
              "tags": tags,
              "upVotes": upVotes,
              "downVotes": downVotes,
              "datePosted": datePosted,
            };
            Log.d("filteredData: $filteredData");
            Log.d("filteredData type: ${filteredData.runtimeType}");
            tempThreads.add(ThreadModel.fromJson(filteredData));
          }

          Log.d("Temp Assignments: $tempThreads");
          threads = tempThreads;
          notifyListeners();
        }
      }

    } catch (e) {
      Log.e('Error: $e');
    }
  }
 
}