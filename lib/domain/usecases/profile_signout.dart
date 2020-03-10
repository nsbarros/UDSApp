import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../repositories/users_repository.dart';

class SignOut extends UseCase<SignOutResponse, void>{
  
  UsersRepository repository;


  SignOut(this.repository);

  @override
  Future<Stream<SignOutResponse>> buildUseCaseStream(void params) async {
    StreamController<SignOutResponse> controller = StreamController();

    try{
      repository.signOut();
      controller.add(SignOutResponse("Sucess"));
      controller.close();
    }catch(e){
      controller.add(e);
    }
    return controller.stream;
  }

}

class SignOutResponse{ 
  String response;

  SignOutResponse(this.response);

}