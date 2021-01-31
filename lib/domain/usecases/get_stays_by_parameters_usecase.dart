import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/stay.dart';
import 'package:sleep_seek_mobile/domain/repositories/stay_repository.dart';

class GetStaysByParametersUseCase
    extends UseCase<List<Stay>, GetStaysByParametersUseCaseParam> {
  StayRepository repository;

  GetStaysByParametersUseCase(this.repository);

  @override
  Future<Stream<List<Stay>>> buildUseCaseStream(
      GetStaysByParametersUseCaseParam params) async {
    final StreamController<List<Stay>> controller = StreamController();
    try {
      List<Stay> stays = await repository.getStaysByParameters(
          pageNumber: params.pageNumber,
          pageSize: params.pageSize,
          properties: params.properties,
          name: params.name,
          country: params.country,
          city: params.city,
          category: params.category,
          dateFrom: params.dateFrom,
          dateTo: params.dateTo,
          order: params.order,
          orderBy: params.orderBy);
      controller.add(stays);
      controller.close();
    } catch (e) {
      logger.severe("GetStaysByParametersUseCase unsuccessful");
      controller.addError(e);
    }

    return controller.stream;
  }
}

class GetStaysByParametersUseCaseParam {
  int pageSize;
  int pageNumber;
  String country;
  String city;
  String dateFrom;
  String dateTo;
  String category;
  List<String> properties;
  String orderBy;
  String order;
  String name;

  GetStaysByParametersUseCaseParam(this.pageNumber, this.pageSize);
}
