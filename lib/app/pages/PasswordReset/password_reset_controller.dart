import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/app/pages/PasswordReset/password_reset_presenter.dart';

class PasswordResetController extends Controller{

  final PasswordResetPresenter passwordResetPresenter;

  PasswordResetController(repository) : passwordResetPresenter = PasswordResetPresenter(repository), super();

  @override
  void initListeners() {
    passwordResetPresenter.getPasswordResetOnNext = (String result){
      ScaffoldState state = getState();

      state.showSnackBar(
          SnackBar(content:
          Text(result, style: TextStyle(color: Theme.of(getContext()).primaryColor),),
          ));

      refreshUI();

    };
    passwordResetPresenter.getPasswordResetOnError = (e){
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      refreshUI();
    };
    passwordResetPresenter.getPasswordResetOnComplete = (){
      print("Password Reset OnComplete");
    };
  }

  void resetPassword(String email){
    passwordResetPresenter.resetPassword(email);
  }

}