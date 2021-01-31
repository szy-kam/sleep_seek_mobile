import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/user.dart';
import 'package:sleep_seek_mobile/domain/repositories/authentication_repository.dart';

class LoginUseCase extends CompletableUseCase<LoginUseCaseParams> {
  AuthenticationRepository _authenticationRepository;

  LoginUseCase(this._authenticationRepository);

  @override
  Future<Stream<User>> buildUseCaseStream(LoginUseCaseParams params) async {
    StreamController<User> controller = StreamController();
    try {
      await _authenticationRepository.authenticate(
          username: params._username, password: params._password);
      controller.close();
    } catch (e) {
      logger.shout(
        'Could not login the user.',
      );
      controller.addError(e);
    }

    return controller.stream;
  }
}

class LoginUseCaseParams {
  String _username;
  String _password;

  LoginUseCaseParams(this._username, this._password);
}
