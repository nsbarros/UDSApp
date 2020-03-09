import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/domain/entities/user.dart';
import 'package:uds_app/domain/repositories/users_repository.dart';

class ProfileController extends Controller{

  UsersRepository repository;

  User user;

  ProfileController(this.repository);

  @override
  void initListeners() {
    // TODO: implement initListeners
  }

}