import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/app/pages/stay/stay_presenter.dart';
import 'package:sleep_seek_mobile/domain/entities/accommodation.dart';
import 'package:sleep_seek_mobile/domain/entities/review.dart';
import 'package:sleep_seek_mobile/domain/entities/stay.dart';

class StayController extends Controller {
  StayPresenter _presenter;
  int stayId;
  Stay stay;
  List<Accommodation> accommodations;
  List<Review> reviews;

  StayController(
      this.stayId, stayRepository, accommodationRepository, reviewRepository)
      : _presenter = StayPresenter(
            stayRepository, accommodationRepository, reviewRepository) {
    retrieveData();
    refreshUI();
  }

  @override
  void initListeners() {
    _presenter.getStayOnComplete = () {};
    _presenter.getStayOnError = (e) {};
    _presenter.getStayOnNext = (s) {
      stay = s;
      refreshUI();
    };
    _presenter.getStayAccommodationOnComplete = () {};
    _presenter.getStayAccommodationOnError = (e) {};
    _presenter.getStayAccommodationOnNext = (r) {
      accommodations = r;
      refreshUI();
    };
    _presenter.getReviewsOnComplete = () {};
    _presenter.getReviewsOnError = (e) {};
    _presenter.getReviewsOnNext = (r) {
      reviews = r;
      refreshUI();
    };
  }

  void retrieveData() {
    _presenter.getStay(stayId);
    refreshUI();
  }
}
