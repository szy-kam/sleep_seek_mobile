import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/accommodation.dart';
import 'package:sleep_seek_mobile/domain/entities/review.dart';
import 'package:sleep_seek_mobile/domain/entities/stay.dart';
import 'package:sleep_seek_mobile/domain/repositories/accommodation_repository.dart';
import 'package:sleep_seek_mobile/domain/repositories/review_repository.dart';
import 'package:sleep_seek_mobile/domain/repositories/stay_repository.dart';
import 'package:sleep_seek_mobile/domain/usecases/get_reviews_usecase.dart';
import 'package:sleep_seek_mobile/domain/usecases/get_stay_accommodations_usecase.dart';
import 'package:sleep_seek_mobile/domain/usecases/get_stay_usecase.dart';

class StayPresenter extends Presenter {
  StayRepository stayRepository;
  AccommodationRepository accommodationRepository;
  ReviewRepository reviewRepository;

  GetStayUseCase _getStaysUseCase;
  GetStayAccommodationsUseCase _getStayAccommodationsUseCase;
  GetReviewsUseCase _getReviewsUseCase;

  Function getStayOnNext;
  Function getStayOnError;
  Function getStayOnComplete;

  Function getStayAccommodationOnNext;
  Function getStayAccommodationOnError;
  Function getStayAccommodationOnComplete;

  Function getReviewsOnNext;
  Function getReviewsOnError;
  Function getReviewsOnComplete;

  StayPresenter(this.stayRepository, this.accommodationRepository,
      this.reviewRepository) {
    _getStayAccommodationsUseCase =
        GetStayAccommodationsUseCase(accommodationRepository);
    _getStaysUseCase = GetStayUseCase(stayRepository);
    _getReviewsUseCase = GetReviewsUseCase(reviewRepository);
  }

  void getStay(int stayId) {
    _getStaysUseCase.execute(
        _GetStayUseCaseObserver(this), GetStayUseCaseParam(stayId));
    _getStayAccommodationsUseCase.execute(_GetStayAccommodationsObserver(this),
        GetStayAccommodationsUseCaseParam(stayId));
    _getReviewsUseCase.execute(
        _GetReviewsObserver(this), GetReviewsUseCaseParam(stayId, 10, 0));
  }

  @override
  void dispose() {
    _getStaysUseCase.dispose();
    _getStayAccommodationsUseCase.dispose();
    _getReviewsUseCase.dispose();
  }
}

class _GetStayAccommodationsObserver implements Observer<List<Accommodation>>{
  StayPresenter _stayPresenter;

  _GetStayAccommodationsObserver(this._stayPresenter);

  @override
  void onComplete() {
    assert(_stayPresenter.getStayAccommodationOnComplete != null);
    _stayPresenter.getStayAccommodationOnComplete();
  }

  @override
  void onError(e) {
    assert(_stayPresenter.getStayAccommodationOnError != null);
    _stayPresenter.getStayAccommodationOnError(e);
  }

  @override
  void onNext(List<Accommodation> response) {
    assert(_stayPresenter.getStayAccommodationOnNext != null);
    _stayPresenter.getStayAccommodationOnNext(response);
  }
}

class _GetReviewsObserver implements Observer<List<Review>> {
  StayPresenter _stayPresenter;

  _GetReviewsObserver(this._stayPresenter);

  @override
  void onComplete() {
    assert(_stayPresenter.getReviewsOnComplete != null);
    _stayPresenter.getReviewsOnComplete();
  }

  @override
  void onError(e) {
    assert(_stayPresenter.getReviewsOnError != null);
    _stayPresenter.getReviewsOnError(e);
  }

  @override
  void onNext(List<Review> response) {
    assert(_stayPresenter.getReviewsOnNext != null);
    _stayPresenter.getReviewsOnNext(response);
  }
}

class _GetStayUseCaseObserver implements Observer<Stay> {
  StayPresenter _stayPresenter;

  _GetStayUseCaseObserver(this._stayPresenter);

  @override
  void onComplete() {
    assert(_stayPresenter.getStayOnComplete != null);
    _stayPresenter.getStayOnComplete();
  }

  @override
  void onError(e) {
    assert(_stayPresenter.getStayOnError != null);
    _stayPresenter.getStayOnError(e);
  }

  @override
  void onNext(Stay stay) {
    assert(_stayPresenter.getStayOnNext != null);
    _stayPresenter.getStayOnNext(stay);
  }
}
