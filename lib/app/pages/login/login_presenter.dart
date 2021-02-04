import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/repositories/authentication_repository.dart';
import 'package:sleep_seek_mobile/domain/usecases/auth/login_usecase.dart';

class LoginPresenter extends Presenter {
  AuthenticationRepository _authenticationRepository;
  LoginUseCase _loginUseCase;

  Function loginOnComplete;
  Function loginOnError;

  LoginPresenter(this._authenticationRepository) {
    _loginUseCase = LoginUseCase(_authenticationRepository);
  }

  void dispose() {
    _loginUseCase.dispose();
  }

  void login({@required String email, @required String password}) {
    _loginUseCase.execute(
        _LoginUserCaseObserver(this), LoginUseCaseParams(email, password));
  }
}

class _LoginUserCaseObserver implements Observer<void> {
  LoginPresenter _loginPresenter;

  _LoginUserCaseObserver(this._loginPresenter);

  void onNext(ignore) {}

  void onComplete() {
    _loginPresenter.loginOnComplete();
  }

  void onError(e) {
    if (_loginPresenter.loginOnError != null) {
      _loginPresenter.loginOnError(e);
    }
  }
}
