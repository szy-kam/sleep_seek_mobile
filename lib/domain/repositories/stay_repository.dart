import 'package:flutter/foundation.dart';
import 'package:sleep_seek_mobile/domain/entities/stay.dart';

abstract class StayRepository {
  Future<void> addStay(
      {@required String name,
      @required String description,
      @required int minPrice,
      @required String email,
      @required String phoneNumber,
      @required String mainPhoto,
      @required String category,
      @required List<String> properties,
      @required List<String> photos,
      @required String city,
      @required String country,
      @required String street,
      @required double longitude,
      @required double latitude});

  Future<void> updateStay(
      {@required int id,
      @required String name,
      @required String description,
      @required int minPrice,
      @required String email,
      @required String phoneNumber,
      @required String mainPhoto,
      @required String category,
      @required List<String> properties,
      @required String city,
      @required String country,
      @required String street,
      @required double longitude,
      @required double latitude,
      @required List<String> photos});

  Future<List<Stay>> getUserStays({@required String username});

  Future<Stay> getStay({@required int id});

  Future<List<Stay>> getStaysByParameters(
      {@required int pageSize,
      @required int pageNumber,
      String country,
      String city,
      String dateFrom,
      String dateTo,
      String category,
      List<String> properties,
      String orderBy,
      String order,
      String name});
}
