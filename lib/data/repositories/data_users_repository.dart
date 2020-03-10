import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:UDSApp/domain/entities/user.dart';
import 'package:UDSApp/domain/repositories/users_repository.dart';

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

  @override
  Future<Stream<User>> getCurrentUser() async {

    Firestore  _firebase = Firestore.instance;

    StreamController<User> controller = StreamController<User>();

    User user;

    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();

    var condition = _firebase.collection("users").where("id" , isEqualTo : "${firebaseUser.uid}");

    condition.getDocuments().then((query){
      query.documents.map((doc){
        User userSelect = User.fromMap(doc.data, doc.documentID);
        user = userSelect;
        controller.add(user);
        controller.close();
        return controller.stream;
      }).toList();
    });

    return controller.stream;
  }

  @override
  Future<void> saveUser(User user) async {
    Firestore _firebase = Firestore.instance;
    await _firebase.collection("users").add(user.toMap());
    return null;
  }

  @override
  Future signOut() async {
    await _firebaseAuth.signOut();
  }

}