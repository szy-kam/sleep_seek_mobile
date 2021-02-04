import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:sleep_seek_mobile/data/utils/constants.dart';
import 'package:sleep_seek_mobile/data/utils/http_helper.dart';
import 'package:sleep_seek_mobile/data/utils/secure_storage.dart';
import 'package:sleep_seek_mobile/domain/entities/review.dart';
import 'package:sleep_seek_mobile/domain/repositories/review_repository.dart';

class DataReviewRepository implements ReviewRepository {
  static DataReviewRepository _instance = DataReviewRepository._internal();

  DataReviewRepository._internal() {
    _logger = Logger('DataAuthenticationRepository');
  }

  Logger _logger;

  final FlutterSecureStorage storage = SecureStorage().storage;

  factory DataReviewRepository() => _instance;

  @override
  Future<void> addReview({int stayId, double rating, String message}) async {
    try {
      String jwt = await storage.read(key: Constants.tokenKey);
      await HttpHelper.invokeHttp(
          Constants.reviewRoute, RequestType.post, body: {
        'stayId': stayId.toString(),
        'rating': rating.toString(),
        'message': message
      }, headers: {
        'Authorization': jwt
      });
    } catch (e) {
      _logger.shout(e.toString());
      _logger.warning(e.message);
      rethrow;
    }
  }

  @override
  Future<List<Review>> getReviews(
      {@required int stayId,
      @required int pageSize,
      @required int pageNumber}) async {
    try {
      Map<String, String> queryParams = {
        'pageSize': pageSize.toString(),
        'pageNumber': pageNumber.toString(),
        'stayId': stayId.toString(),
      };
      queryParams.removeWhere((key, value) => value == null);
      Uri uri =
      Uri.http(Constants.baseUrlNoPrefix, Constants.reviewPath, queryParams);
      List<Review> result =
      (jsonDecode(await HttpHelper.invokeHttp3(uri, RequestType.get))
      as List)
          .map((e) => Review.fromJson(e))
          .toList();
      return result;
    } catch (e) {
      _logger.shout(e.toString());
      _logger.warning(e.message);
      rethrow;
    }
  }
}
