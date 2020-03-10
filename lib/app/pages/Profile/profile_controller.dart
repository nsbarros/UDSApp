import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:UDSApp/domain/entities/user.dart';
import 'package:UDSApp/domain/repositories/users_repository.dart';

import 'profile_presenter.dart';

class ProfileController extends Controller{

  UsersRepository repository;
  ProfilePresenter presenter;

  User user;

  ProfileController(this.repository) : presenter = ProfilePresenter(repository), super();

  @override
  void initListeners() {
    presenter.profilePresenterOnNext = (User result){
      user = result;
      refreshUI();
    };

    presenter.profilePresenterOnErro = (e){
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      refreshUI();
    };

    presenter.profilePresenterOnComplete = (){};

    presenter.signOutUseCaseOnNext = (String result) {
      Future.delayed(Duration(seconds: 2)).then((_){
        Navigator.of(getContext()).pop();
      });
    };

    presenter.signOutUseCaseOnErro = (e){
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      refreshUI();
      Future.delayed(Duration(seconds: 10)).then((_){
        Navigator.of(getContext()).pop();
      });
    };

    presenter.signOutUseCaseOnComplete = (){
      print("signOutUseCaseOnComplete");
    };

  }

  void getUser(){
    presenter.getUser();
  }

  void signOut(){
    presenter.signOut();
  }

}