import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/app/pages/SignUp/signup_presenter.dart';
import 'package:uds_app/domain/repositories/users_repository.dart';

class SignUpController extends Controller{

  final UsersRepository repository;

  SignUpPresenter presenter;

  SignUpController(this.repository): presenter = SignUpPresenter(repository), super();

  @override
  void initListeners() {
      presenter.getSingUpOnNext = (result){
        print("Resultado: ${result}");
        ScaffoldState state = getState();
        state.setState((){
          Navigator.pop(getContext());
        });
      };

      presenter.getSingUpOnComplete = () {
        //
      };

      presenter.getSingUpOnError = (e) {
        ScaffoldState state = getState();
        state.showSnackBar(SnackBar(content: Text(e.message)));
        refreshUI(); // Refreshes the UI manually
      };
  }

  void signUp(String email, String password, String name){
    presenter.signUp(email, password, name);
  }

}

