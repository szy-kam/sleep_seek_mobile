import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/user.dart';
import 'package:sleep_seek_mobile/domain/repositories/authentication_repository.dart';

class SignUpUseCase extends CompletableUseCase<SignUpUseCaseParams> {
  AuthenticationRepository _authenticationRepository;

  SignUpUseCase(this._authenticationRepository);

  @override
  Future<Stream<User>> buildUseCaseStream(SignUpUseCaseParams params) async {
    final StreamController<User> controller = StreamController();
    try {
      await _authenticationRepository.signUp(
          username: params._username,
          password: params._password,
          displayName: params._displayName);
      controller.close();
    } catch (e) {
      logger.severe('SignUpUseCase unsuccessful.', e);
      controller.addError(e);
    }
    return controller.stream;
  }
}

class SignUpUseCaseParams {
  String _username;
  String _displayName;
  String _password;

  SignUpUseCaseParams(this._username, this._displayName, this._password);
}
