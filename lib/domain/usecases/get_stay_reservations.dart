import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/reservation.dart';
import 'package:sleep_seek_mobile/domain/repositories/reservation_repository.dart';

class GetStayReservationsUseCase
    extends UseCase<List<Reservation>, GetStayReservationsUseCaseParam> {
  ReservationRepository repository;

  GetStayReservationsUseCase(this.repository);

  @override
  Future<Stream<List<Reservation>>> buildUseCaseStream(
      GetStayReservationsUseCaseParam params) async {
    final StreamController<List<Reservation>> controller = StreamController();
    try {
      List<Reservation> reservations =
          await repository.getStayReservation(stayId: params.stayId);
      controller.add(reservations);
      controller.close();
    } catch (e) {
      logger.severe("GetStayReservationsUseCase unsuccessful");
      controller.addError(e);
    }

    return controller.stream;
  }
}

class GetStayReservationsUseCaseParam {
  int stayId;

  GetStayReservationsUseCaseParam(this.stayId);
}
