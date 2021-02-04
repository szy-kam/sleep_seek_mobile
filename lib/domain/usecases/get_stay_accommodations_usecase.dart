import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/accommodation.dart';
import 'package:sleep_seek_mobile/domain/repositories/accommodation_repository.dart';

class GetStayAccommodationsUseCase
    extends UseCase<List<Accommodation>, GetStayAccommodationsUseCaseParam> {
  AccommodationRepository repository;

  GetStayAccommodationsUseCase(this.repository);

  @override
  Future<Stream<List<Accommodation>>> buildUseCaseStream(
      GetStayAccommodationsUseCaseParam params) async {
    final StreamController<List<Accommodation>> controller = StreamController();
    try {
      List<Accommodation> accommodations =
          await repository.getAccommodation(stayId: params.stayId);
      controller.add(accommodations);
      controller.close();
    } catch (e) {
      logger.severe("GetStayAccommodationUseCase unsuccessful");
      controller.addError(e);
    }

    return controller.stream;
  }
}

class GetStayAccommodationsUseCaseParam {
  int stayId;

  GetStayAccommodationsUseCaseParam(this.stayId);
}
