import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class Environment {
  static const String baseURL = String.fromEnvironment(
    
    'BASE_URL',
    // defaultValue: 'https://smash-back-end-lms.vercel.app/',
    //defaultValue: 'http://192.168.0.102:8080/',
    defaultValue: 'https://smash-back-end-lms.vercel.app/',
  );
}
