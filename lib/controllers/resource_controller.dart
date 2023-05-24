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
}
