import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:UDSApp/domain/entities/pauta.dart';
import 'package:UDSApp/domain/repositories/pauta_repository.dart';

class PautaOpenUseCase extends UseCase<PautaOpenUseCaseResponse, PautaOpenParams>{

  PautaRepository repository;

  PautaOpenUseCase(this.repository);

  @override
  Future<Stream<PautaOpenUseCaseResponse>> buildUseCaseStream(PautaOpenParams params) async {
    final StreamController<PautaOpenUseCaseResponse> controller = StreamController();

      try{
        Pauta pauta = params.pauta;
        pauta.status = "open";
       await repository.updateStatusOpen(pauta);
       controller.add(PautaOpenUseCaseResponse("Pauta sucessfully opened"));
       controller.close();
      }catch(e){
        controller.addError(e);
      }

    return controller.stream;
  }

}

class PautaOpenUseCaseResponse{
  String result;

  PautaOpenUseCaseResponse(this.result);

}

class PautaOpenParams{
  Pauta pauta;

  PautaOpenParams(this.pauta);

}