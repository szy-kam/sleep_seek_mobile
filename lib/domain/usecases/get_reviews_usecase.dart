import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/review.dart';
import 'package:sleep_seek_mobile/domain/repositories/review_repository.dart';

class GetReviewsUseCase extends UseCase<List<Review>, GetReviewsUseCaseParam> {
  ReviewRepository repository;

  GetReviewsUseCase(this.repository);

  @override
  Future<Stream<List<Review>>> buildUseCaseStream(
      GetReviewsUseCaseParam params) async {
    final StreamController<List<Review>> controller = StreamController();
    try {
      List<Review> reviews = await repository.getReviews(stayId: params.stayId);
      controller.add(reviews);
      controller.close();
    } catch (e) {
      logger.severe("GetReviewsUseCase unsuccessful");
      controller.addError(e);
    }

    return controller.stream;
  }
}

class GetReviewsUseCaseParam {
  int stayId;

  GetReviewsUseCaseParam(this.stayId);
}
