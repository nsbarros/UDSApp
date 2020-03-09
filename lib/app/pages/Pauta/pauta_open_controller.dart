import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/app/pages/Pauta/pauta_open_present.dart';
import 'package:uds_app/domain/entities/pauta.dart';

class PautaOpenController extends Controller {

  PautaOpenPresenter presenter;
  List<Pauta> listOpen = List();


  PautaOpenController(repository)
      : presenter = PautaOpenPresenter(repository),
        super();

  @override
  void initListeners() {
    presenter.getFindOpenUsecaseOnNext = (List<Pauta> list) {
      listOpen = list;
      refreshUI();
    };

    presenter.getFindOpenUsecaseOnError = (e){
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      refreshUI();
    };

    presenter.getFindOpenUsecaseOnComplete = (){
      print("OnComplete PautaOpenController");
    };

    presenter.getPautaFinishUseCaseOnNext = (String result){
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(result)));
      refreshUI();
      presenter.getListPautaOpen();
    };

    presenter.getPautaFinishUseCaseOnError = (e){
      ScaffoldState state = getState();
      state.showSnackBar(SnackBar(content: Text(e.message)));
      refreshUI();
    };

    presenter.getPautaFinishUseCaseOnComplete = (){
      print("OnComplete getPautaFinishUseCaseOnComplete");
    };

  }

  void finishPauta(Pauta pauta){
    presenter.finishPauta(pauta);
  }

  void getListPautaOpen(){
    presenter.getListPautaOpen();
  }

}