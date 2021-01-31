import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/accommodation.dart';
import 'package:sleep_seek_mobile/domain/repositories/accommodation_repository.dart';

class UpdateAccommodationUseCase
    extends CompletableUseCase<UpdateAccommodationUseCaseParams> {
  AccommodationRepository accommodationRepository;

  UpdateAccommodationUseCase(this.accommodationRepository) : super();

  @override
  Future<Stream<Accommodation>> buildUseCaseStream(
      UpdateAccommodationUseCaseParams params) async {
    final StreamController<Accommodation> controller = StreamController();
    try {
      await accommodationRepository.updateAccommodation(
          id: params.id,
          stayId: params.stayId,
          sleepersCapacity: params.sleepersCapacity,
          quantity: params.quantity,
          price: params.price,
          properties: params.properties);
      controller.close();
    } catch (e) {
      logger.severe("UpdateAccommodationUseCase unsuccessful");
      controller.addError(e);
    }
    return controller.stream;
  }
}

class UpdateAccommodationUseCaseParams {
  int id;
  int stayId;
  int sleepersCapacity;
  int quantity;
  int price;
  List<String> properties;

  UpdateAccommodationUseCaseParams(this.id, this.stayId, this.sleepersCapacity,
      this.quantity, this.price, this.properties);
}
