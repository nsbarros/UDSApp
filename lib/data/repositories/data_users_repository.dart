import 'package:firebase_auth/firebase_auth.dart';
import 'package:uds_app/domain/entities/user.dart';
import 'package:uds_app/domain/repositories/users_repository.dart';

class DataUsersRepository extends UsersRepository{

   FirebaseAuth _firebaseAuth = null;

  List<User> users;

  // sigleton
  static DataUsersRepository _instance = DataUsersRepository._internal();

  DataUsersRepository._internal() {
    _firebaseAuth = FirebaseAuth.instance;
  }
  factory DataUsersRepository() => _instance;

  @override
  User getUser(String email) {
    return users[0];
  }

  @override
  User searchUser(String email, password) {
    return User(0, "nathan", "nathan", "123");
  }

  @override
  Future toSaveUser(User user) {
    return null;
  }

  @override
  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  @override
  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return null;
  }

}