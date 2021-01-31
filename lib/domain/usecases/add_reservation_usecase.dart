import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/reservation.dart';
import 'package:sleep_seek_mobile/domain/repositories/reservation_repository.dart';

class AddReservationUseCase
    extends CompletableUseCase<AddReservationUseCaseParams> {
  ReservationRepository reservationRepository;

  AddReservationUseCase(this.reservationRepository) : super();

  @override
  Future<Stream<Reservation>> buildUseCaseStream(
      AddReservationUseCaseParams params) async {
    final StreamController<Reservation> controller = StreamController();
    try {
      await reservationRepository.addReservation(
          accommodationId: params.accommodationId,
          customerFullName: params.customerFulLName,
          customerUsername: params.customerUsername,
          customerPhoneNumber: params.customerPhoneNumber,
          dateFrom: params.dateFrom,
          dateTo: params.dateTo);

      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }
}

class AddReservationUseCaseParams {
  int accommodationId;
  String customerFulLName;
  String customerUsername;
  String customerPhoneNumber;
  String dateFrom;
  String dateTo;

  AddReservationUseCaseParams(
      this.accommodationId,
      this.customerFulLName,
      this.customerUsername,
      this.customerPhoneNumber,
      this.dateFrom,
      this.dateTo);
}
