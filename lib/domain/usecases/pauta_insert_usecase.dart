import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:UDSApp/domain/entities/pauta.dart';
import 'package:UDSApp/domain/repositories/pauta_repository.dart';

class PautaInsertUseCase extends UseCase<PautaInsertUseCaseResponse, PautaInsertUseCaseParams>{

  PautaRepository repository;

  PautaInsertUseCase(this.repository);

  @override
  Future<Stream<PautaInsertUseCaseResponse>> buildUseCaseStream(PautaInsertUseCaseParams params) async {
    StreamController<PautaInsertUseCaseResponse> _controller = StreamController();
    try{
      await repository.insertPauta(params.pauta);
      _controller.add(PautaInsertUseCaseResponse("Inserted successfully!"));
    }catch(e){
      _controller.addError(e);
    }
    return _controller.stream;
  }
}

class PautaInsertUseCaseResponse{
  String mensagem;
  PautaInsertUseCaseResponse(this.mensagem);
}

class PautaInsertUseCaseParams{
  Pauta pauta;
  PautaInsertUseCaseParams(this.pauta);
}