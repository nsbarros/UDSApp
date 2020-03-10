import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:UDSApp/domain/entities/user.dart';
import 'package:UDSApp/domain/repositories/users_repository.dart';

class ProfileUseCase extends UseCase<ProfileUseCaseResponse, void> {
  UsersRepository repository;

  ProfileUseCase(this.repository);

  @override
  Future<Stream<ProfileUseCaseResponse>> buildUseCaseStream(void params) async {
    final StreamController<ProfileUseCaseResponse> _controller =
        StreamController();
    try {
      repository.getCurrentUser().then((user) {
        user.listen((value) {
          if (value != null) {
            _controller.add(ProfileUseCaseResponse(value));
            _controller.close();
          }
        });
      });

    } catch (e) {
      _controller.addError(e);
    }
    return _controller.stream;
  }
}

class ProfileUseCaseResponse {
  User user;

  ProfileUseCaseResponse(this.user);
}
