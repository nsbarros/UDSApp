import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/app/pages/Pauta/pauta_finish_presenter.dart';
import 'package:uds_app/domain/entities/pauta.dart';

class PautaFinishController extends Controller{

  PautaFinishPresenter presenter;
  List<Pauta> listFinish;

  PautaFinishController(repository) : presenter = PautaFinishPresenter(repository), super();

  @override
  void initListeners() {
    presenter.findFinishGetList = (List<Pauta> list){
      listFinish = list;
      refreshUI();
    };

    presenter.findFinishGetListErro = (e){
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      refreshUI();
    };

    presenter.findFinishGetListOnComplete = (){
      print("OnComplete PautaFinishController");
    };

    presenter.getPautaOpenPresenterOnComplete = (){

    };

    presenter.getPautaOpenPresenterOnNext = (String message){
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(message)));
      presenter.listFinish();
    };

    presenter.getPautaOpenPresenterOnError = (e){
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      presenter.listFinish();
    };

  }

  void openPauta(Pauta pauta){
    presenter.openPauta(pauta);
  }

  void getListFinishPautas(){
    presenter.listFinish();
  }

}