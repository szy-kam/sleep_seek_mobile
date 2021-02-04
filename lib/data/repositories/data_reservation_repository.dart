import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:sleep_seek_mobile/data/utils/constants.dart';
import 'package:sleep_seek_mobile/data/utils/http_helper.dart';
import 'package:sleep_seek_mobile/data/utils/secure_storage.dart';
import 'package:sleep_seek_mobile/domain/entities/reservation.dart';
import 'package:sleep_seek_mobile/domain/repositories/reservation_repository.dart';

class DataReservationRepository implements ReservationRepository {
  static DataReservationRepository _instance =
      DataReservationRepository._internal();

  DataReservationRepository._internal() {
    _logger = Logger('DataAuthenticationRepository');
  }

  Logger _logger;

  final FlutterSecureStorage storage = SecureStorage().storage;

  factory DataReservationRepository() => _instance;

  @override
  Future<void> addReservation(
      {int accommodationTemplateId,
      String customerFullName,
      String customerUsername,
      String customerPhoneNumber,
      String dateFrom,
      String dateTo}) async {
    try {
      String jwt = await storage.read(key: Constants.tokenKey);
      await HttpHelper.invokeHttp(Constants.reviewRoute, RequestType.post,
          body: {
            'customer': {
              'customerFullName': customerFullName,
              'customerPhoneNumber': customerPhoneNumber
            },
            'dateFrom': dateFrom,
            'dateTo': dateTo,
            'accommodationTemplateId': accommodationTemplateId
          },
          headers: {
            'Authorization': jwt
          });
    } catch (e) {
      _logger.shout(e.toString());
      _logger.warning(e.message);
      rethrow;
    }
  }

  @override
  Future<List<Reservation>> getUserReservation(
      {String username, int pageSize, int pageNumber}) async {
    try {
      Map<String, String> queryParams = {
        'pageSize': pageSize.toString(),
        'pageNumber': pageNumber.toString(),
        'username': username,
      };
      queryParams.removeWhere((key, value) => value == null);
      Uri uri = Uri.http(
          Constants.baseUrlNoPrefix, Constants.reservationPath, queryParams);
      List<Reservation> result =
          (jsonDecode(await HttpHelper.invokeHttp3(uri, RequestType.get))
                  as List)
              .map((e) => Reservation.fromJson(e))
              .toList();
      return result;
    } catch (e) {
      _logger.shout(e.toString());
      _logger.warning(e.message);
      rethrow;
    }
  }
}
