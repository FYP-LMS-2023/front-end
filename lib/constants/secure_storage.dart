import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  factory SecureStorage() => _instance;
  SecureStorage._internal();

  final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
  final String token = 'token';

  Future setToken(String token) async {
    await storage.write(key: this.token, value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: token);
  }
}
