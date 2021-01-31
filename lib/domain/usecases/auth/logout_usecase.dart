import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
import 'package:sleep_seek_mobile/domain/entities/user.dart';
import 'package:sleep_seek_mobile/domain/repositories/authentication_repository.dart';

class LogoutUseCase extends CompletableUseCase<void> {
  AuthenticationRepository _authenticationRepository;
  Logger _logger;

  LogoutUseCase(this._authenticationRepository) {
    _logger = Logger('LogoutUseCase');
  }

  @override
  Future<Stream<User>> buildUseCaseStream(void ignore) async {
    final StreamController<User> controller = StreamController();
    try {
      await _authenticationRepository.logout();
      controller.close();
    } catch (e) {
      _logger.shout('Could not logout user');
      controller.addError(e);
    }
    return controller.stream;
  }
}
