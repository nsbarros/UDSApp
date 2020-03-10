import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:UDSApp/domain/entities/user.dart';
import 'package:UDSApp/domain/repositories/pauta_repository.dart';

class GetUserUseCase extends UseCase<GetUserUseCaseResponse, void>{

  PautaRepository repository;


  GetUserUseCase(this.repository);

  @override
  Future<Stream<GetUserUseCaseResponse>> buildUseCaseStream(void params) async {
    final StreamController<GetUserUseCaseResponse> _controller = StreamController();

    try {
      var currentUser = await repository.getCurrentUser();
      _controller.add(GetUserUseCaseResponse(currentUser));
      _controller.close();
    }catch(e){
      _controller.addError(e);
    }
    return _controller.stream;
  }
}

class GetUserUseCaseResponse{
  User user;
  GetUserUseCaseResponse(this.user);
}