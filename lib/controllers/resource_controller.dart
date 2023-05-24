import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import '../models/resource_model.dart';

class ResourceController extends ChangeNotifier {
  final secureStorage = SecureStorage();

  List<ResourceModel>? resources;

  List<ResourceModel>? get getResources => resources;

  Future<void> getAllResources(String id) async {
    try {
      final token = await secureStorage.getToken();

      final response = await http.get(
        Uri.parse('${Environment.baseURL}resource/getClassResources/$id'),
        headers: <String, String>{'Authorization': token ?? ''},
      );

      Log.e(jsonDecode(response.body));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as List<dynamic>;

        // Log.v(responseData);

        resources = responseData.map((e) => ResourceModel.fromJson(e)).toList();

        Log.w(resources!.length);

        notifyListeners();
      }
    } catch (e) {
      print('Widget ID: $id');
      print('Error: $e');
    }
  }

  Future<bool> createResource(
    Map<String, dynamic> data,
    List<File>? files,
  ) async {
    try {
      final token = await secureStorage.getToken();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${Environment.baseURL}resource/uploadResource'),
      );

      request.headers['Authorization'] = token ?? '';

      request.fields['classID'] = data['classID'];
      request.fields['title'] = data['title'];
      request.fields['description'] = data['description'];

      for (File f in files!) {
        final mimeTypeData =
            lookupMimeType(f.path, headerBytes: [0xFF, 0xD8])?.split('/');
        final file = await http.MultipartFile.fromPath("files", f.path,
            contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));

        request.files.add(file);

        final streamedResponse = await request.send();

        final response = await http.Response.fromStream(streamedResponse);

        Log.i('response: ${response.body}');

        if (response.statusCode == 200) {
          Log.e('Response: ${response.body}');
          return true;
        } else {
          Log.e('Error: ${response.body}');
          return false;
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }

  Future<bool> updateResource(Map<String, dynamic> data, String id) async {
    try {
      final token = await secureStorage.getToken();
      final response = await http.patch(
        Uri.parse('${Environment.baseURL}resource/updateResource/$id'),
        headers: <String, String>{
          'Authorization': token ?? '',
        },
        body: data,
      );
      if (response.statusCode != 200) {
        Log.e("Error: ${response.body}");
        return false;
      } else {
        Log.v("Response: ${response.body}");
        return true;
      }
    } catch (e) {
      Log.e('$e');
    }
    return false;
  }

  Future<bool> deleteFile(int index, String id) async {
    try {
      final token = await secureStorage.getToken();
      final response = await http.patch(
        Uri.parse(
            '${Environment.baseURL}resource/removeFileByIndexFromResource/$id/$index'),
        headers: <String, String>{
          'Authorization': token ?? '',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      Log.i("response: ${response.body}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> addFile(List<File>? files, String id) async {
    // Log.d()
    for (File f in files!) {
      Log.d(f.path);
    }
    Log.d(id);
    try {
      final token = await secureStorage.getToken();
      var request = http.MultipartRequest('PATCH',
          Uri.parse('${Environment.baseURL}resource/addFileToResource/$id'));

      request.headers['Authorization'] = token ?? '';

      for (File f in files) {
        final mimeTypeData =
            lookupMimeType(f.path, headerBytes: [0xFF, 0xD8])?.split('/');
        final file = await http.MultipartFile.fromPath("files", f.path,
            contentType: MediaType(mimeTypeData![0], mimeTypeData[1]));

        request.files.add(file);
      }

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      Log.i(
          'Response Status Code: ${response.statusCode} - ${response.reasonPhrase}');

      if (response.statusCode != 200) {
        Log.e("Error: ${response.body}");
        return false;
      } else {
        Log.v("Response: ${response.body}");
        return true;
      }
    } catch (e) {
      Log.e(e.toString());
    }

    return false;
  }

  Future<bool> deleteResource(String id, String classID) async {
    try {
      final token = await secureStorage.getToken();
      var headers = {
        'Authorization': token ?? "",
        'Content-Type': 'application/json'
      };
      var request = http.Request('PATCH',
          Uri.parse('${Environment.baseURL}resource/deleteResource/$id'));
      request.body = json.encode({"classID": classID});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      Log.e('$e');
    }
    return false;
  }
}
