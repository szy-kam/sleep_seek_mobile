import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
import 'package:sleep_seek_mobile/domain/entities/user.dart';
import 'package:sleep_seek_mobile/domain/repositories/authentication_repository.dart';

class GetCurrentUserUseCase extends UseCase<User, void> {
  AuthenticationRepository _authenticationRepository;
  Logger _logger;

  GetCurrentUserUseCase(this._authenticationRepository) {
    _logger = Logger('GetCurrentUserUseCase');
  }

  @override
  Future<Stream<User>> buildUseCaseStream(void ignore) async {
    final StreamController<User> controller = StreamController();
    try {
      User user = await _authenticationRepository.getCurrentUser();
      controller.add(user);
      controller.close();
    } catch (e) {
      _logger.shout('GetCurrentUserUseCase unsuccessful.');
      controller.addError(e);
    }
    return controller.stream;
  }
}
