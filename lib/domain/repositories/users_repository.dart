
import 'package:uds_app/domain/entities/user.dart';

import '../entities/user.dart';

abstract class UsersRepository{
  User getUser(String email);
  Future toSaveUser(User user);
  Future<String> signUp(String email, String password);
  Future<String> signIn(String email, String password);
  Future<void> resetPassword(String email);
  Future<Stream<User>> getCurrentUser();
  Future signOut();

  Future<void> saveUser(User user);
}