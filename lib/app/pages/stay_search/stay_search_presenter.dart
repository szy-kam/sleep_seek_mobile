import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/stay.dart';
import 'package:sleep_seek_mobile/domain/repositories/stay_repository.dart';
import 'package:sleep_seek_mobile/domain/usecases/get_stays_by_parameters_usecase.dart';

class StaySearchPresenter extends Presenter {
  StayRepository stayRepository;
  GetStaysByParametersUseCase _getStaysByParametersUseCase;

  Function getStaysByParametersOnNext;
  Function getStaysByParametersOnError;
  Function getStaysByParametersOnComplete;

  StaySearchPresenter(this.stayRepository) {
    _getStaysByParametersUseCase = GetStaysByParametersUseCase(stayRepository);
  }

  void getStays(int pageNumber, int pageSize, String city, String country,
      List<String> properties, String priceFrom, String priceTo) {
    _getStaysByParametersUseCase.execute(
        _GetStaysByParameterObserver(this),
        GetStaysByParametersUseCaseParam(
            pageNumber: pageNumber,
            pageSize: pageSize,
            city: city,
            country: country,
            properties: properties,
            priceFrom: priceFrom,
            priceTo: priceTo));
  }

  @override
  void dispose() {
    _getStaysByParametersUseCase.dispose();
  }
}

class _GetStaysByParameterObserver implements Observer<List<Stay>> {
  StaySearchPresenter _presenter;

  _GetStaysByParameterObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.getStaysByParametersOnComplete();
  }

  @override
  void onError(e) {
    _presenter.getStaysByParametersOnError(e);
  }

  @override
  void onNext(List<Stay> response) {
    _presenter.getStaysByParametersOnNext(response);
  }
}
