import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/domain/repositories/users_repository.dart';

class PasswordResetUseCase extends UseCase<PasswordResetUseCaseResponse, PasswordResetParams>{
  
  UsersRepository repository;
  
  PasswordResetUseCase(this.repository);

  @override
  Future<Stream<PasswordResetUseCaseResponse>> buildUseCaseStream(PasswordResetParams params) async {

    final StreamController<PasswordResetUseCaseResponse> controller = StreamController();
    try{
      await repository.resetPassword(params.email);
      controller.add(PasswordResetUseCaseResponse("Email sent to ${params.email}"));
      controller.close();
    }catch(e){
      controller.addError(e);
    }

    return controller.stream;
  }

}

class PasswordResetParams{
  final String email;

  PasswordResetParams(this.email);

}

 class PasswordResetUseCaseResponse{
  String response;

  PasswordResetUseCaseResponse(this.response);

 }