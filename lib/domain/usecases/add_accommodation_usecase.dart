import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/accommodation.dart';
import 'package:sleep_seek_mobile/domain/repositories/accommodation_repository.dart';

class AddAccommodationUseCase
    extends CompletableUseCase<AddAccommodationUseCaseParams> {
  AccommodationRepository accommodationRepository;

  AddAccommodationUseCase(this.accommodationRepository) : super();

  @override
  Future<Stream<Accommodation>> buildUseCaseStream(
      AddAccommodationUseCaseParams params) async {
    final StreamController<Accommodation> controller = StreamController();
    try {
      await accommodationRepository.addAccommodation(
          stayId: params.stayId,
          sleepersCapacity: params.sleepersCapacity,
          quantity: params.quantity,
          price: params.price,
          properties: params.properties);
      controller.close();
    } catch (e) {
      logger.severe("AddAccommodationUseCase unsuccessful");
      controller.addError(e);
    }
    return controller.stream;
  }
}

class AddAccommodationUseCaseParams {
  int stayId;
  int sleepersCapacity;
  int quantity;
  int price;
  List<String> properties;

  AddAccommodationUseCaseParams(this.stayId, this.sleepersCapacity,
      this.quantity, this.price, this.properties);
}
