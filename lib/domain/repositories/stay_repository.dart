import 'package:flutter/foundation.dart';
import 'package:sleep_seek_mobile/domain/entities/stay.dart';

abstract class StayRepository {
  Future<Stay> getStay({@required int id});

  Future<List<Stay>> getStaysByParameters(
      {@required int pageSize,
      @required int pageNumber,
      String country,
      String city,
      String dateFrom,
      String dateTo,
      String category,
      String priceFrom,
      String priceTo,
      List<String> properties,
      String orderBy,
      String order,
      String name});
}
