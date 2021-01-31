import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/domain/entities/stay.dart';
import 'package:sleep_seek_mobile/domain/repositories/stay_repository.dart';

class GetStayUseCase extends UseCase<Stay, GetStayUseCaseParam> {
  StayRepository repository;

  GetStayUseCase(this.repository);

  @override
  Future<Stream<Stay>> buildUseCaseStream(GetStayUseCaseParam params) async {
    final StreamController<Stay> controller = StreamController();
    try {
      Stay stay = await repository.getStay(id: params.id);
      controller.add(stay);
      controller.close();
    } catch (e) {
      logger.severe("GetStayUseCase unsuccessful");
      controller.addError(e);
    }

    return controller.stream;
  }
}

class GetStayUseCaseParam {
  int id;

  GetStayUseCaseParam(this.id);
}
