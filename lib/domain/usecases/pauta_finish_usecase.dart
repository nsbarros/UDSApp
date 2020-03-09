import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/domain/entities/pauta.dart';
import 'package:uds_app/domain/repositories/pauta_repository.dart';

class PautaFinishUseCase
    extends UseCase<PautaFinishUseCaseResponse, PautaFinishParamns> {

  PautaRepository repository;

  PautaFinishUseCase(this.repository);

  @override
  Future<Stream<PautaFinishUseCaseResponse>> buildUseCaseStream(
      PautaFinishParamns params) async {

    final StreamController<PautaFinishUseCaseResponse> controller = StreamController();

    try {
      Pauta pauta = params.pauta;
      pauta.status = "close";
      await repository.updateStatusPautaFinish(pauta);
      controller.add(PautaFinishUseCaseResponse("Pauta finished sucessfully"));
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}

class PautaFinishUseCaseResponse {
  String result;

  PautaFinishUseCaseResponse(this.result);

}

class PautaFinishParamns {
  Pauta pauta;

  PautaFinishParamns(this.pauta);

}