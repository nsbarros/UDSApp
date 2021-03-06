import 'package:UDSApp/data/repositories/data_users_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../Navigator/welcome_view.dart';
import 'home_presenter.dart';

class HomeController extends Controller{

  final HomePresenter homePresenter;

  DataUsersRepository repository;

  HomeController(this.repository) : homePresenter = HomePresenter(repository), super();

  @override
  void initListeners() {
    homePresenter.getUserOnNext = (String result) {
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(result,
        style: TextStyle(color: Theme
            .of(getContext())
            .primaryColor),)));
      refreshUI();
      state.setState((){
        Navigator.push(getContext(), MaterialPageRoute(builder: (context) => Welcome()));
      });
    };

    homePresenter.getUserOnComplete = () {
      print('User retrieved');
    };

    homePresenter.getUserOnError = (e) {
      print('Could not retrieve user.');
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      refreshUI(); // Refreshes the UI manually
    };

  }

  void logIn(String email, String password){
    homePresenter.logIn(email, password);
  }

}