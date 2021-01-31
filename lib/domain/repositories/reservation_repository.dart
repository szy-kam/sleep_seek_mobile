import 'package:flutter/foundation.dart';
import 'package:sleep_seek_mobile/domain/entities/reservation.dart';

abstract class ReservationRepository {
  Future<void> addReservation({@required int accommodationId,
    @required String customerFullName,
    @required String customerUsername,
    @required String customerPhoneNumber,
    @required String dateFrom,
    @required String dateTo});

  Future<List<Reservation>> getStayReservation({@required int stayId});

  Future<List<Reservation>> getUserReservation({@required String username});
}