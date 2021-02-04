import 'package:flutter/foundation.dart';
import 'package:sleep_seek_mobile/domain/entities/user.dart';

abstract class AuthenticationRepository {
  Future<void> signUp(
      {@required String username,
      @required String password,
      @required String displayName});

  Future<void> authenticate(
      {@required String username, @required String password});

  Future<bool> isAuthenticated();

  Future<User> getCurrentUser();

  Future<void> logout();
}
