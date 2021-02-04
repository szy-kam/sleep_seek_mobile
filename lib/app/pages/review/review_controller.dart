import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/app/pages/review/review_presenter.dart';

class ReviewController extends Controller {
  ReviewPresenter _reviewPresenter;

  ReviewController(reviewRepo)
      : _reviewPresenter = ReviewPresenter(reviewRepo) {}

  void _addReviewOnComplete() {}

  void _addReviewOnError() {}

  @override
  void initListeners() {
    // TODO: implement initListeners
  }
}
