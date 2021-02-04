import 'package:flutter/foundation.dart';
import 'package:sleep_seek_mobile/domain/entities/reservation.dart';

abstract class ReservationRepository {
  Future<void> addReservation({@required int accommodationTemplateId,
    @required String customerFullName,
    @required String customerUsername,
    @required String customerPhoneNumber,
    @required String dateFrom,
    @required String dateTo});

  Future<List<Reservation>> getUserReservation({@required String username, @required int pageNumber, @required int pageSize});
}