import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:UDSApp/domain/entities/pauta.dart';
import 'package:UDSApp/domain/entities/user.dart';
import 'package:UDSApp/domain/repositories/pauta_repository.dart';

class DataPautaRepository extends PautaRepository {
  Firestore _firebase = null;
  FirebaseAuth _firebaseAuth = null;
  // sigleton
  static DataPautaRepository _instance = DataPautaRepository._internal();

  DataPautaRepository._internal() {
    _firebase = Firestore.instance;
    _firebaseAuth = FirebaseAuth.instance;
  }

  factory DataPautaRepository() => _instance;

  @override
  Future<List<Pauta>> listFinish() async {
    List<Pauta> list = List();
    var ref = _firebase.collection("pautas");

    await ref.getDocuments().then((querysnapshot) {
      querysnapshot.documents.map((doc) {
        Pauta p = Pauta.fromMap(doc.data, doc.documentID);
        if(p.status == "close"){
          list.add(Pauta.fromMap(doc.data, doc.documentID));
        }
      }).toList();
    });
    return list;
  }

  @override
  Future<List<Pauta>> listOpen() async {
    List<Pauta> list = List();
    var ref = _firebase.collection("pautas");
    await ref.getDocuments().then((querysnapshot) {
      querysnapshot.documents.map((doc) {
        Pauta p = Pauta.fromMap(doc.data, doc.documentID);
        if(p.status == "open"){
          list.add(Pauta.fromMap(doc.data, doc.documentID));
        }
      }).toList();
    });
    return list;
  }

  @override
  Future<void> updateStatusOpen(Pauta pauta) async {
    CollectionReference ref = _firebase.collection("pautas");
    await ref.document(pauta.id).updateData(pauta.toJson());
    return ;
  }

  @override
  Future<void> updateStatusPautaFinish(Pauta pauta) async {
    CollectionReference ref = _firebase.collection("pautas");
    await ref.document(pauta.id).updateData(pauta.toJson());
    return ;
  }

  @override
  Future<void> insertPauta(Pauta pauta) async {
    CollectionReference ref = _firebase.collection("pautas");
    await ref.add(pauta.toMap());
    return null;
  }

  @override
  Future<User> getCurrentUser() async {
    User user;
    await _firebaseAuth.currentUser().then((firebaseUser) async {
      var condition = _firebase.collection("users").where("id" , isEqualTo : "${firebaseUser.uid}");
      await condition.getDocuments().then((query){
        query.documents.map((doc){
          User userSelect = User.fromMap(doc.data, doc.documentID);
          user = userSelect;
        }).toList();
      });
    });
    return user;
  }
}
