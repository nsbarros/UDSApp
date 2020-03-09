
import 'package:uds_app/domain/entities/user.dart';

abstract class UsersRepository{
  User getUser(String email);
  Future toSaveUser(User user);
  User searchUser(String email, password);
  Future<String> signUp(String email, String password);
  Future<String> signIn(String email, String password);
  Future<void> resetPassword(String email);
  User getCurrentUser(String uId);
}