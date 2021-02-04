import 'package:flutter/foundation.dart';
import 'package:sleep_seek_mobile/domain/entities/accommodation.dart';

abstract class AccommodationRepository {
  Future<List<Accommodation>> getAccommodation({@required int stayId});
}
