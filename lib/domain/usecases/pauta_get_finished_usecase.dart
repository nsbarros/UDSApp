import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/domain/entities/pauta.dart';
import 'package:uds_app/domain/repositories/pauta_repository.dart';

class FindFinishUsecase extends UseCase<FindFinishUsecaseResponse, void>{
  
  PautaRepository repository;

  FindFinishUsecase(this.repository);

  @override
  Future<Stream<FindFinishUsecaseResponse>> buildUseCaseStream(void params) async {
      
    final StreamController<FindFinishUsecaseResponse> controller = StreamController();
    try{
     List<Pauta> list = await repository.listFinish();
     controller.add(FindFinishUsecaseResponse(list));
     controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }
  
}

class FindFinishUsecaseResponse{
  List<Pauta> pautas;

  FindFinishUsecaseResponse(this.pautas);

}
