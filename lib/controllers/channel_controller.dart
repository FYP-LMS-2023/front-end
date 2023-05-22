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

  ThreadModel? threadObject;

  ThreadModel? get getThreadObject => threadObject;

  List<ThreadModel>? threads;

  List<ThreadModel>? get getThreads => threads;


Future<void> createThread(String id, String title, String description, List<String> tags) async {
  try {
    final token = await secureStorage.getToken();
    
    final requestBody = {
      'title': title,
      'description': description,
      'tags': tags.toList(),
    };
    Log.d("Channel Id: $id");
    final encodedBody = jsonEncode(requestBody);

    Log.d('Request Body: $encodedBody'); // Add this line to inspect the encoded request body content
    
    final response = await http.post(
      Uri.parse('${Environment.baseURL}channel/createThread/$id'),
      headers: <String, String>{
        'Authorization': token ?? "",
        'Content-Type': 'application/json',
      },
      body: encodedBody,
    );

    Log.d("Response Status Code: ${response.statusCode}");

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final threadsData = responseData["result"];
      Log.d("Threads Data: $threadsData");
      Log.d("Threads Data is not Empty: ${threadsData.isNotEmpty}");

      notifyListeners();
    }
  } catch (e) {
    Log.e('Error: $e');
  }
}

Future<void> getThreadDetails(String id) async {
  try {
    final token = await secureStorage.getToken();
    final response = await http.get(
      Uri.parse('${Environment.baseURL}channel/getThread/$id'),
      headers: <String, String>{'Authorization': token ?? ""},
    );
    Log.d("Response Status Code: ${response.statusCode}");

    if(response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      Log.d("Thread Data: $responseData");
      Log.d("Thread Data is not Empty: ${responseData.isNotEmpty}");

      if (responseData.isNotEmpty) { 
        var id = responseData["_id"];
        var postedBy = responseData["postedBy"];
        var title = responseData["title"];
        var description = responseData["description"];
        var comments = responseData["comments"];
        var tags = responseData["tags"];
        var datePosted = responseData["datePosted"];
        var upVoteCount = responseData["upvoteCount"];
        var downVoteCount = responseData["downvoteCount"];
        var commentsCount = responseData["comments"].length;

        final filteredData = {
          "_id" : id,
          "postedBy" : postedBy,
          "title" : title,
          "description" : description,
          "comments" : comments,
          "tags" : tags,
          "datePosted" : datePosted,
          "upvoteCount" : upVoteCount,
          "downvoteCount" : downVoteCount,
          "commentsCount" : commentsCount,
        };

        Log.d("filteredData: $filteredData");
        Log.d("filteredData type: ${filteredData.runtimeType}");

        threadObject = ThreadModel.fromJson(filteredData);
        
      }
      notifyListeners();
    }
  } catch (e) {
    Log.e('Error coming in get thread details: $e');
  }
}

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
            var commentsCount = data["comments"].length;
            var tags = data["tags"];
            var upVotes = data["upVotes"];
            var downVotes = data["downVotes"];
            var datePosted = data["datePosted"];
            var upVoteCount = data["upvoteCount"];
            var downVoteCount = data["downvoteCount"];

            final filteredData = {
              "_id": id,
              "title": title,
              "description": description,
              "postedBy": postedBy,
              "commentsCount": commentsCount,
              "tags": tags,
              "upVotes": upVotes,
              "downVotes": downVotes,
              "datePosted": datePosted,
              "upvoteCount": upVoteCount,
              "downvoteCount": downVoteCount,
            };
            Log.d("filteredData: $filteredData");
            Log.d("Comments Count: $commentsCount");
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