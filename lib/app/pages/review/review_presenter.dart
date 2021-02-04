import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/repositories/review_repository.dart';
import 'package:sleep_seek_mobile/domain/usecases/add_review_usecase.dart';

class ReviewPresenter extends Presenter {
  ReviewRepository reviewRepository;

  ReviewPresenter(this.reviewRepository) {
    addReviewUseCase = AddReviewUseCase(reviewRepository);
  }

  AddReviewUseCase addReviewUseCase;
  Function addReviewOnComplete;
  Function addReviewOnError;

  @override
  void dispose() {
    addReviewUseCase.dispose();
  }
}
