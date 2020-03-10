import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:UDSApp/domain/repositories/users_repository.dart';

import '../entities/user.dart';

class SignUpUseCase extends UseCase<SignUpUseCaseResponde, SignUpUseCaseParams> {

  final UsersRepository repository;
  
  SignUpUseCase(this.repository);
  String message;

  @override
  Future<Stream<SignUpUseCaseResponde>> buildUseCaseStream(SignUpUseCaseParams params) async {
    
    final StreamController<SignUpUseCaseResponde> controller =
        StreamController();

    try{
      validadeEmailPassword(params, controller);
      String result =  await repository.signUp(params.email, params.password);
      User user = User(result, params.name, params.email, params.password);
      await repository.saveUser(user);
      if(result != null){
        message = "Welcome to UDS technology";
      }
      controller.add(SignUpUseCaseResponde(message));
      controller.close();
    }catch(e){
      controller.addError(e);
    }

    return controller.stream;
  }

  void validadeEmailPassword(
      SignUpUseCaseParams params, StreamController<SignUpUseCaseResponde> controller) {
    if (params.email.isEmpty) {
      throw Exception("E-mail é obrigatório");
    }

    if (params.password.isEmpty) {
      throw Exception("Senha é obrigatório");
    }
  }

}

class SignUpUseCaseResponde{
  String mResult;
  SignUpUseCaseResponde(this.mResult);
}

class SignUpUseCaseParams{
  final String email, password, name;
  SignUpUseCaseParams(this.email, this.password, this.name);
}