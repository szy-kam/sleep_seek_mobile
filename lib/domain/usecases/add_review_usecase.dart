import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/review.dart';
import 'package:sleep_seek_mobile/domain/repositories/review_repository.dart';

class AddReviewUseCase extends CompletableUseCase<AddReviewUseCaseParams> {
  ReviewRepository reviewRepository;

  AddReviewUseCase(this.reviewRepository) : super();

  @override
  Future<Stream<Review>> buildUseCaseStream(
      AddReviewUseCaseParams params) async {
    final StreamController<Review> controller = StreamController();
    try {
      await reviewRepository.addReview(
          message: params.message,
          rating: params.rating,
          stayId: params.stayId);

      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}

class AddReviewUseCaseParams {
  String message;
  double rating;
  int stayId;

  AddReviewUseCaseParams(this.message, this.rating, this.stayId);
}
