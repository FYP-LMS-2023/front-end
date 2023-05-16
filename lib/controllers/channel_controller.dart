import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end/constants/env.dart';
import 'package:front_end/constants/secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/log.dart';
import '../models/channel_model.dart';

class ChannelController extends ChangeNotifier {
  final secureStorage = SecureStorage();

  Future<void> getAllThreads(String id) async {
    
  }
 
}