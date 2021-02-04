import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:sleep_seek_mobile/data/utils/constants.dart';
import 'package:sleep_seek_mobile/data/utils/http_helper.dart';
import 'package:sleep_seek_mobile/data/utils/secure_storage.dart';
import 'package:sleep_seek_mobile/domain/entities/user.dart';
import 'package:sleep_seek_mobile/domain/repositories/authentication_repository.dart';

class DataAuthenticationRepository implements AuthenticationRepository {
  static DataAuthenticationRepository _instance =
      DataAuthenticationRepository._internal();

  DataAuthenticationRepository._internal() {
    _logger = Logger('DataAuthenticationRepository');
  }

  Logger _logger;

  final FlutterSecureStorage storage = SecureStorage().storage;

  factory DataAuthenticationRepository() => _instance;

  @override
  Future<void> authenticate({String username, String password}) async {
    try {
      String jwt = await HttpHelper.invokeHttp3(
          Constants.loginRoute, RequestType.post,
          body: jsonEncode({'username': username, 'password': password}),
          headers: {'Accept': '*/*'},
          encoding: Encoding.getByName("gzip, deflate, br"));
      storage.write(key: Constants.tokenKey, value: jwt);
      storage.write(key: Constants.isAuthenticatedKey, value: "true");
    } catch (e) {
      _logger.shout(e.toString());
      _logger.warning(e.message);
      rethrow;
    }
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      Map<String, dynamic> map = await HttpHelper.invokeHttp(
          Constants.currentUserRoute, RequestType.get, headers: {
        'Authorization': await storage.read(key: Constants.tokenKey)
      });
      return User.fromJson(map);
    } catch (e) {
      _logger.warning(e.message);
      rethrow;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    String isAuthenticated =
        await storage.read(key: Constants.isAuthenticatedKey);
    return isAuthenticated == null || isAuthenticated == "false" ? false : true;
  }

  @override
  Future<void> logout() async {
    try {
      storage.delete(key: Constants.tokenKey);
      storage.write(key: Constants.isAuthenticatedKey, value: "false");
    } catch (e) {}
  }

  @override
  Future<void> signUp(
      {String username, String password, String displayName}) async {
    try {
      await HttpHelper.invokeHttp(Constants.signUpRoute, RequestType.post,
          body: {
            'username': username,
            'password': password,
            'displayName': displayName
          });
    } catch (e) {
      _logger.warning(e.message);
      rethrow;
    }
  }
}
