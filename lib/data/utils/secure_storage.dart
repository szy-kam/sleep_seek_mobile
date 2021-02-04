import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static SecureStorage _instance = SecureStorage._internal();

  FlutterSecureStorage secureStorage;

  SecureStorage._internal() {
    secureStorage = FlutterSecureStorage();
  }

  factory SecureStorage() => _instance;

  FlutterSecureStorage get storage => secureStorage;
}
