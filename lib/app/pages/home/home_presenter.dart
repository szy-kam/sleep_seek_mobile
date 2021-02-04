import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/stay.dart';
import 'package:sleep_seek_mobile/domain/entities/user.dart';
import 'package:sleep_seek_mobile/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:sleep_seek_mobile/domain/usecases/get_stays_by_parameters_usecase.dart';

class HomePresenter extends Presenter {
  Function getUserOnNext;
  Function getUserOnComplete;
  Function getUserOnError;
  Function getStaysByParametersOnNext;
  Function getStaysByParametersOnComplete;
  Function getStaysByParametersOnError;

  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final GetStaysByParametersUseCase _getStaysByParametersUseCase;

  HomePresenter(authenticationRepository, staysRepository)
      : _getCurrentUserUseCase =
            GetCurrentUserUseCase(authenticationRepository),
        _getStaysByParametersUseCase =
            GetStaysByParametersUseCase(staysRepository);

  @override
  void dispose() {
    _getStaysByParametersUseCase.dispose();
    _getCurrentUserUseCase.dispose();
  }

  void getRecentStays() {
    _getStaysByParametersUseCase.execute(_GetStaysByParametersObserver(this),
        GetStaysByParametersUseCaseParam(pageNumber: 0, pageSize: 10));
  }

  void getUser() {
    _getCurrentUserUseCase.execute(_GetUserUseCaseObserver(this));
  }
}

class _GetStaysByParametersObserver extends Observer<List<Stay>> {
  final HomePresenter _homePresenter;

  _GetStaysByParametersObserver(this._homePresenter);

  @override
  void onComplete() {
    assert(_homePresenter.getStaysByParametersOnComplete != null);
    _homePresenter.getStaysByParametersOnComplete();
  }

  @override
  void onError(e) {
    assert(_homePresenter.getStaysByParametersOnError != null);
    _homePresenter.getStaysByParametersOnError(e);
  }

  @override
  void onNext(List<Stay> response) {
    assert(_homePresenter.getStaysByParametersOnNext != null);
    _homePresenter.getStaysByParametersOnNext(response);
  }
}

class _GetUserUseCaseObserver extends Observer<User> {
  HomePresenter _userPresenter;

  _GetUserUseCaseObserver(this._userPresenter);

  void onNext(user) {
    assert(user is User);
    _userPresenter.getUserOnNext(user);
  }

  void onComplete() {
    assert(_userPresenter.getUserOnComplete != null);
    _userPresenter.getUserOnComplete();
  }

  void onError(e) {
    assert(_userPresenter.getUserOnError != null);
    _userPresenter.getUserOnError(e);
  }
}
