import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/reservation.dart';
import 'package:sleep_seek_mobile/domain/repositories/reservation_repository.dart';

class GetUserReservationsUseCase
    extends UseCase<List<Reservation>, GetUserReservationsUseCaseParam> {
  ReservationRepository repository;

  GetUserReservationsUseCase(this.repository);

  @override
  Future<Stream<List<Reservation>>> buildUseCaseStream(
      GetUserReservationsUseCaseParam params) async {
    final StreamController<List<Reservation>> controller = StreamController();
    try {
      List<Reservation> reservations =
          await repository.getUserReservation(username: params.username);
      controller.add(reservations);
      controller.close();
    } catch (e) {
      logger.severe("GetUserReservationsUseCase unsuccessful");
      controller.addError(e);
    }

    return controller.stream;
  }
}

class GetUserReservationsUseCaseParam {
  String username;

  GetUserReservationsUseCaseParam(this.username);
}
