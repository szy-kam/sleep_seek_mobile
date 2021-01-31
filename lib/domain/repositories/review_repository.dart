import 'package:flutter/foundation.dart';
import 'package:sleep_seek_mobile/domain/entities/review.dart';

abstract class ReviewRepository {
  Future<void> addReview({@required int stayId,
    @required double rating,
    @required String message});


  Future<List<Review>> getReviews({@required int stayId});
}