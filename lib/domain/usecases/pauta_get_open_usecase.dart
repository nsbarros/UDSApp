import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/domain/entities/pauta.dart';
import 'package:uds_app/domain/repositories/pauta_repository.dart';

class FindOpenUsecase extends UseCase<FindOpenUsecaseResponse, void> {

  PautaRepository repository;

  FindOpenUsecase(this.repository);

  @override
  Future<Stream<FindOpenUsecaseResponse>> buildUseCaseStream(void params) async {
    final StreamController<FindOpenUsecaseResponse> controller = StreamController();
    try{
      List<Pauta> list = await repository.listOpen();
      controller.add(FindOpenUsecaseResponse(list));
      controller.close();
    }catch(e){
      print(e.toString());
    }
    return controller.stream;
  }

}

class FindOpenUsecaseResponse{
  List<Pauta> list;

  FindOpenUsecaseResponse(this.list);

}
