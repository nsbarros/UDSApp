import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/domain/entities/user.dart';
import 'package:uds_app/domain/repositories/pauta_repository.dart';

class GetUserUseCase extends UseCase<GetUserUseCaseResponse, void>{

  PautaRepository repository;


  GetUserUseCase(this.repository);

  @override
  Future<Stream<GetUserUseCaseResponse>> buildUseCaseStream(void params) async {
    final StreamController<GetUserUseCaseResponse> _controller = StreamController();
    try{
      await repository.getCurrentUser().then((user) {
        user.listen((value) {
          if (value != null) {
            _controller.add(GetUserUseCaseResponse(value));
            _controller.close();
          }
        });
      });
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