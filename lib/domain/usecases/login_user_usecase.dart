import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/domain/repositories/users_repository.dart';

class LoginUseCase extends UseCase<LoginUseCaseResponde, LoginUseCaseParams> {

  final UsersRepository repository;

  LoginUseCase(this.repository);
  String message;

  @override
  Future<Stream<LoginUseCaseResponde>> buildUseCaseStream(
      LoginUseCaseParams params) async {

    final StreamController<LoginUseCaseResponde> controller = StreamController();

    try {
      validadeInputFrom(params, controller);
      String result = await repository.signIn(params.email, params.password);
      if(result != null){
        message = "Welcome to UDS technology";
      }
      controller.add(LoginUseCaseResponde(message));
      logger.finest("User sucessfully loaded");
      controller.close();
    } catch (e) {
      controller.addError(e);
    }

    return controller.stream;
  }

  void validadeInputFrom(
      LoginUseCaseParams params, StreamController<LoginUseCaseResponde> controller) {
    if (params.email.isEmpty || params.password.isEmpty) {
      throw Exception("E-mail ou Senha Inválido!");
    }
  }
}

class LoginUseCaseParams {
  final String email, password;

  LoginUseCaseParams(this.email, this.password);
}

class LoginUseCaseResponde {
  final String result;

  LoginUseCaseResponde(this.result);
}
