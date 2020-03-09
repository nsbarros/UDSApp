import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/domain/entities/user.dart';
import 'package:uds_app/domain/repositories/users_repository.dart';

class ProfileUseCase extends UseCase<ProfileUseCaseResponse, ProfileParams>{

  UsersRepository repository;

  ProfileUseCase(this.repository);

  @override
  Future<Stream<ProfileUseCaseResponse>> buildUseCaseStream(ProfileParams params) async {
    final StreamController<ProfileUseCaseResponse> _controller = StreamController();

   try{
     User user = await repository.getCurrentUser(params.uId); //continuar aqui
     _controller.add(ProfileUseCaseResponse(user));
     _controller.close();
   }catch(e){
     _controller.addError(e);
   }

    return _controller.stream;
  }

}

class ProfileUseCaseResponse{
  User user;

  ProfileUseCaseResponse(this.user);
}

class ProfileParams {
  String uId;

  ProfileParams(this.uId);

}