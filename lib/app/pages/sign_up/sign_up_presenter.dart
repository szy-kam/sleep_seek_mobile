import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/repositories/authentication_repository.dart';
import 'package:sleep_seek_mobile/domain/usecases/auth/sign_up_usecase.dart';

class SignUpPresenter extends Presenter {
  AuthenticationRepository _authenticationRepository;
  SignUpUseCase _signUpUseCase;

  Function signUpOnError;
  Function signUpOnComplete;

  SignUpPresenter(this._authenticationRepository) {
    _signUpUseCase = SignUpUseCase((_authenticationRepository));
  }

  void signUp({@required String email, @required String password, @required String displayName}){
    _signUpUseCase.execute(_SignUpUseCaseObserver(this), SignUpUseCaseParams(email, password, displayName));
  }

  @override
  void dispose() {
    _signUpUseCase.dispose();
  }
}

class _SignUpUseCaseObserver extends Observer<void> {
  SignUpPresenter _signUpPresenter;

  _SignUpUseCaseObserver(this._signUpPresenter);

  @override
  void onComplete() {
    _signUpPresenter.signUpOnComplete();
  }

  @override
  void onError(e) {
    if (_signUpPresenter.signUpOnError != null) {
      _signUpPresenter.signUpOnError();
    }
  }

  @override
  void onNext(ignore) {}
}
