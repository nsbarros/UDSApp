import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/app/pages/Pauta/pauta_insert_presenter.dart';
import 'package:uds_app/domain/entities/pauta.dart';
import 'package:uds_app/domain/entities/user.dart';
import 'package:uds_app/domain/repositories/pauta_repository.dart';

class AddPautaController extends Controller{

  PautaRepository repository;
  PautaInsertPresenter presenter;

  User user;

  AddPautaController(this.repository): presenter = PautaInsertPresenter(repository), super();

  @override
  void initListeners() {
      presenter.insertPautaNext = (String result){
        ScaffoldState state = getState();
        state.showSnackBar(SnackBar(content: Text(result)));
        refreshUI();
        Future.delayed(Duration(seconds: 2)).then((_){
          Navigator.of(getContext()).pop();
        });
      };
      presenter.insertPautaError = (e){
        ScaffoldState state = getState();
        state.showSnackBar(SnackBar(content: Text(e.message)));
        refreshUI();
      };

      presenter.insertPautaComplete = (){};

      presenter.getUserNext = (User result){
        user = result;
        refreshUI();
      };

      presenter.getUserError = (e){
        ScaffoldState state = getState();
        state.showSnackBar(SnackBar(content: Text(e.message)));
        refreshUI();
      };

      presenter.getUserComplete = (){};

  }

  void add(Pauta pauta){
    presenter.add(pauta);
  }

  void getUser(){
    presenter.getUser();
  }
}