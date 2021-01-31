import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/repositories/authentication_repository.dart';

class GetAuthenticationStatusUseCase extends UseCase<bool, void> {
  AuthenticationRepository _authenticationRepository;

  GetAuthenticationStatusUseCase(this._authenticationRepository);

  @override
  Future<Stream<bool>> buildUseCaseStream(void ignore) async {
    final StreamController<bool> controller = StreamController();
    try {
      bool isAuth = await _authenticationRepository.isAuthenticated();
      controller.add(isAuth);
      controller.close();
    } catch (e) {
      logger.shout("GetAuthenticationStatusUseCase unsuccessful");
      controller.addError(e);
    }
    return controller.stream;
  }
}
