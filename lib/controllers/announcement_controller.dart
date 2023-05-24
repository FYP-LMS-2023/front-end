import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/log.dart';
import '../models/announcement_model.dart';

class AnnouncementController extends ChangeNotifier {
  final secureStorage = SecureStorage();

  AnnouncementModel? announcementObject;

  AnnouncementModel? get getAnnouncementObject => announcementObject;

  List<AnnouncementModel>? announcements;

  List<AnnouncementModel>? get getAnnouncements => announcements;

  Future<void> getAnnouncementDetails(String id) async {
    try {
      final token = await secureStorage.getToken();
      final response = await http.get(
        Uri.parse('${Environment.baseURL}announcement/getAnnouncement/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
      );

      Log.d("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final announcementData = responseData["announcement"];
        Log.d("Announcement Data: $announcementData");
        Log.d("Announcement Data is not Empty: ${announcementData.isNotEmpty}");

        if (announcementData.isNotEmpty) {
          Log.d("Data: $announcementData");
          var id = announcementData["_id"];
          var announcementType = announcementData["announcementType"];
          var datePosted = announcementData["datePosted"];
          var title = announcementData["title"];
          var description = announcementData["description"];
          var postedBy = announcementData["postedBy"];

          final filteredData = {
            "_id": id,
            "announcementType": announcementType,
            "title": title,
            "description": description,
            "datePosted": datePosted,
            "postedBy": postedBy,
          };
          Log.d("filteredData: $filteredData");
          Log.d("filteredData type: ${filteredData.runtimeType}");

          announcementObject = AnnouncementModel.fromJson(filteredData);
        }
        notifyListeners();
      }
    } catch (e) {
      print("Error coming: $e");
    }
  }

  Future<void> getAllAnnouncements(String id) async {
    try {
      final token = await secureStorage.getToken();
      // print('testing: $test');
      final response = await http.get(
        Uri.parse(
            '${Environment.baseURL}announcement/getAllClassAnnouncements/$id'),
        headers: <String, String>{'Authorization': token ?? ""},
        // body: <String, String>{"classID": id},
      );

      Log.d("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final announcementsData =
            responseData["announcements"] as List<dynamic>;
        Log.d("Announcements Data: $announcementsData");
        Log.d(
            "Announcements Data is not Empty: ${announcementsData.isNotEmpty}");
        List<AnnouncementModel> tempAnnouncements = [];

        if (announcementsData.isNotEmpty) {
          tempAnnouncements = [];
          for (var data in announcementsData) {
            Log.d("Data: $data");
            var id = data["_id"];
            var title = data["title"];
            var description = data["description"];
            var postedBy = data["postedBy"];
            var datePosted = data["datePosted"];

            final filteredData = {
              "_id": id,
              "title": title,
              "description": description,
              "postedBy": postedBy,
              "datePosted": datePosted,
            };
            Log.d("filteredData: $filteredData");
            Log.d("filteredData type: ${filteredData.runtimeType}");
            tempAnnouncements.add(AnnouncementModel.fromJson(filteredData));
          }

          announcements = tempAnnouncements;
          notifyListeners();
        } else {
          announcements = [];
          notifyListeners();
        }
      } else {
        announcements = [];
        notifyListeners();
      }
    } catch (e, s) {
      Log.e('<Error>: $e $s');
    }
  }

  Future<bool> createAnnouncement(
    Map<String, dynamic> data,
  ) async {
    Log.i(data);
    try {
      final token = await secureStorage.getToken();
      var headers = {
        'Authorization': token ?? "",
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST',
          Uri.parse('${Environment.baseURL}announcement/createAnnouncement'));
      request.body = json.encode({
        "title": data['title'],
        "description": data['description'],
        "classID": data['classID'],
        "announcementType": data['announcementType'],
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        return false;
      }

      // var request = http.MultipartRequest(
      //   'POST',
      //   Uri.parse('${Environment.baseURL}announcement/createAnnouncement'),
      // );

      // request.headers['Authorization'] = token ?? '';

      // request.fields['classID'] = data['classID'];
      // request.fields['title'] = data['title'];
      // request.fields['description'] = data['description'];
      // request.fields['announcementType'] = data['announcementType'];

      // final streamedResponse = await request.send();

      // final response = await http.Response.fromStream(streamedResponse);

      // Log.i('response: ${response.body}');

      // if (response.statusCode == 200) {
      //   Log.e('Response: ${response.body}');
      //   return true;
      // } else {
      //   Log.e('Error: ${response.body}');
      //   return false;
      // }
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }
}
