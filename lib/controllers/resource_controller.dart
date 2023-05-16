import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/log.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:http/http.dart' as http;

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

      //Log.e(response);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as List<dynamic>;
        // final resourcesData = Json.decoderesponseData['resources'] as List<dynamic>;

        List<ResourceModel> tempResources = [];

        // resources = responseData
        //     .map((resourceData) => ResourceModel(
        //         title: resourceData["title"],
        //         //dateUploaded: resourceData["uploadDate"],
        //         files: resourceData["files"]
        //             .map((filesData) => File(url: filesData["url"]))
        //             .toList()))
        //     .toList();

        // resources = responseData.map((e) {
          
        // })

        Log.e(resources![0].title);

        // if (resourcesData.isNotEmpty) {
        //   for (var data in resourcesData) {
        //     var id = data['_id'];
        //     var uploadedBy = data['uploadedBy'];
        //     var dateUploaded = data['dateUploaded'];
        //     var fileSize = data['fileSize'];
        //     var fileType = data['fileType'];
        //     var fileLink = data['fileLink'];
        //     var fileName = data['fileName'];

        //     final filteredData = {
        //       '_id': id,
        //       'uploadedBy': uploadedBy,
        //       'dateUploaded': dateUploaded,
        //       'fileSize': fileSize,
        //       'fileType': fileType,
        //       'fileLink': fileLink,
        //       'fileName': fileName,
        //     };

        //   tempResources.add(ResourceModel.fromJson(filteredData));
        // }

        // resources = tempResources;
        notifyListeners();
        //}
      }
    } catch (e) {
      print('Widget ID: $id');
      print('Error: $e');
    }
  }
}
