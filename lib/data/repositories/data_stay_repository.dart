import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:sleep_seek_mobile/data/utils/constants.dart';
import 'package:sleep_seek_mobile/data/utils/http_helper.dart';
import 'package:sleep_seek_mobile/domain/entities/stay.dart';
import 'package:sleep_seek_mobile/domain/repositories/stay_repository.dart';

class DataStayRepository implements StayRepository {
  static DataStayRepository _instance = DataStayRepository._internal();

  DataStayRepository._internal() {
    _logger = Logger("DataStayRepository");
  }

  factory DataStayRepository() => _instance;

  Logger _logger;

  @override
  Future<Stay> getStay({@required int id}) async {
    try {
      Uri uri = Uri.http(
          Constants.baseUrlNoPrefix, Constants.stayPath + "/" + id.toString());
      Map<String, dynamic> result =
          await HttpHelper.invokeHttp(uri, RequestType.get);
      return Stay.fromJson(result);
    } catch (e) {
      _logger.shout(e.toString());
      _logger.warning(e.message);
      rethrow;
    }
  }

  @override
  Future<List<Stay>> getStaysByParameters(
      {@required int pageSize,
      @required int pageNumber,
      String country,
      String city,
      String dateFrom,
      String dateTo,
      String priceFrom,
      String priceTo,
      String category,
      List<String> properties,
      String orderBy,
      String order,
      String name}) async {
    try {
      Map<String, String> queryParams = {
        'pageSize': pageSize.toString(),
        'pageNumber': pageNumber.toString(),
        'country': country,
        'city': city,
        'category': category,
        'priceFrom': priceFrom,
        'priceTo': priceTo,
        'orderBy': orderBy,
        'order': order,
        'dateFrom': dateFrom,
        'dateTo': dateTo
      };
      queryParams.removeWhere((key, value) => value == null);
      Uri uri =
          Uri.http(Constants.baseUrlNoPrefix, Constants.stayPath, queryParams);
      http.Response response = await http.get(uri);
      List<dynamic> body = json.decode(response.body);
      if (body.length == 0) {
        return List<Stay>();
      }
      List<Stay> stays = body.map((e) => Stay.fromJson(e)).toList();
      return stays;
    } catch (e, st) {
      print(st);
      _logger.shout(e.toString());
      _logger.warning(e.message);
      rethrow;
    }
  }
}
