import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/stay.dart';
import 'package:sleep_seek_mobile/domain/repositories/stay_repository.dart';

class UpdateStayUseCase extends CompletableUseCase<UpdateStayUseCaseParams> {
  StayRepository stayRepository;

  UpdateStayUseCase(this.stayRepository) : super();

  @override
  Future<Stream<Stay>> buildUseCaseStream(
      UpdateStayUseCaseParams params) async {
    final StreamController<Stay> controller = StreamController();
    try {
      await stayRepository.updateStay(
          id: params.id,
          category: params.category,
          city: params.city,
          country: params.country,
          description: params.description,
          email: params.email,
          latitude: params.latitude,
          longitude: params.longitude,
          mainPhoto: params.mainPhoto,
          minPrice: params.minPrice,
          name: params.name,
          phoneNumber: params.phoneNumber,
          properties: params.properties,
          street: params.street,
          photos: params.photos);
      controller.close();
    } catch (e) {
      logger.severe("UpdateStayUseCase unsuccessful");
      controller.addError(e);
    }
    return controller.stream;
  }
}

class UpdateStayUseCaseParams {
  int id;
  String name;
  String username;
  String description;
  String email;
  String mainPhoto;
  String category;
  int minPrice;
  String phoneNumber;
  List<String> photos;
  List<String> properties;
  String city;
  String country;
  String street;
  String zipCode;
  double latitude;
  double longitude;

  UpdateStayUseCaseParams(
      this.id,
      this.name,
      this.username,
      this.description,
      this.email,
      this.minPrice,
      this.mainPhoto,
      this.category,
      this.phoneNumber,
      this.photos,
      this.properties,
      this.city,
      this.country,
      this.street,
      this.zipCode,
      this.latitude,
      this.longitude);
}
