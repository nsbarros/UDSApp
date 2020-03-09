import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/domain/entities/pauta.dart';
import 'package:uds_app/domain/usecases/pauta_get_finished_usecase.dart';
import 'package:uds_app/domain/usecases/pauta_open_usecase.dart';

class PautaFinishPresenter extends Presenter{
  
  PautaOpenUseCase pautaOpenUseCase;

  FindFinishUsecase findFinishUsecase;

  Function findFinishGetList;
  Function findFinishGetListErro;
  Function findFinishGetListOnComplete;

  Function getPautaOpenPresenterOnNext;
  Function getPautaOpenPresenterOnComplete;
  Function getPautaOpenPresenterOnError;


  PautaFinishPresenter(repository): pautaOpenUseCase = PautaOpenUseCase(repository),
        findFinishUsecase = FindFinishUsecase(repository) ;
  
  void openPauta(Pauta pauta){
    pautaOpenUseCase.execute(GetPautaOpenPresenterOberserver(this), PautaOpenParams(pauta));
  }

  void listFinish(){
    findFinishUsecase.execute(_GetFindFinishPresenterOberver(this), (){});
  }

  @override
  void dispose() {
    pautaOpenUseCase.dispose();
  }
  
}

class _GetFindFinishPresenterOberver extends Observer <FindFinishUsecaseResponse> {

  PautaFinishPresenter presenter;


  _GetFindFinishPresenterOberver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.findFinishGetListOnComplete != null);
    presenter.findFinishGetListOnComplete;
  }

  @override
  void onError(e) {
    assert(presenter.findFinishGetListErro != null);
    presenter.findFinishGetListErro(e);
  }

  @override
  void onNext(FindFinishUsecaseResponse response) {
    assert(presenter.findFinishGetList != null);
    presenter.findFinishGetList(response.pautas);
  }
}

class GetPautaOpenPresenterOberserver extends Observer<PautaOpenUseCaseResponse> {
  
  PautaFinishPresenter presenter;


  GetPautaOpenPresenterOberserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.getPautaOpenPresenterOnComplete != null);
    presenter.getPautaOpenPresenterOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.getPautaOpenPresenterOnError != null);
    presenter.getPautaOpenPresenterOnError(e);
  }

  @override
  void onNext(PautaOpenUseCaseResponse response) {
    assert(presenter.getPautaOpenPresenterOnNext != null);
    presenter.getPautaOpenPresenterOnNext(response.result);
  } 
}