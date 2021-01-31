import 'package:flutter/foundation.dart';
import 'package:sleep_seek_mobile/domain/entities/accommodation.dart';

abstract class AccommodationRepository {
  Future<void> addAccommodation(
      {@required int stayId,
      @required int sleepersCapacity,
      @required int quantity,
      @required int price,
      @required List<String> properties});

  Future<void> updateAccommodation(
      {@required int id,
      @required int stayId,
      @required int sleepersCapacity,
      @required int quantity,
      @required int price,
      @required List<String> properties});

  Future<List<Accommodation>> getAccommodation({@required int stayId});
}
