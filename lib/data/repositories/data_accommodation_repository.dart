import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:sleep_seek_mobile/data/utils/constants.dart';
import 'package:sleep_seek_mobile/data/utils/http_helper.dart';
import 'package:sleep_seek_mobile/domain/entities/accommodation.dart';
import 'package:sleep_seek_mobile/domain/repositories/accommodation_repository.dart';

class DataAccommodationRepository implements AccommodationRepository {
  static DataAccommodationRepository _instance =
  DataAccommodationRepository._internal();

  DataAccommodationRepository._internal() {
    _logger = Logger('DataAccommodationRepository');
  }

  Logger _logger;


  factory DataAccommodationRepository() => _instance;

  @override
  Future<List<Accommodation>> getAccommodation({int stayId}) async{
    try {
      Map<String, String> queryParams = {
        'pageSize': "10",
        'pageNumber': "0",
        'stayId' : stayId.toString()
      };
      queryParams.removeWhere((key, value) => value == null);
      Uri uri =
      Uri.http(Constants.baseUrlNoPrefix, Constants.accommodationTemplatePath, queryParams);
      List<Accommodation> result =
      (jsonDecode(await HttpHelper.invokeHttp3(uri, RequestType.get))
      as List)
          .map((e) => Accommodation.fromJson(e))
          .toList();
      return result;
    } catch (e) {
      _logger.shout(e.toString());
      _logger.warning(e.message);
      rethrow;
    }
  }
}
