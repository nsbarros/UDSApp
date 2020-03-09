import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/domain/entities/pauta.dart';
import 'package:uds_app/domain/usecases/pauta_finish_usecase.dart';
import 'package:uds_app/domain/usecases/pauta_get_open_usecase.dart';

class  PautaOpenPresenter extends Presenter {

  PautaFinishUseCase pautaFinishUseCase;

  Function getPautaFinishUseCaseOnNext;
  Function getPautaFinishUseCaseOnComplete;
  Function getPautaFinishUseCaseOnError;

  FindOpenUsecase  pautaOpenGetListCase;

  Function getFindOpenUsecaseOnNext;
  Function getFindOpenUsecaseOnComplete;
  Function getFindOpenUsecaseOnError;


  PautaOpenPresenter(repository): pautaFinishUseCase = PautaFinishUseCase(repository), pautaOpenGetListCase =  FindOpenUsecase(repository);

  void finishPauta(Pauta pauta){
    pautaFinishUseCase.execute(_GetPautaFisishObserver(this), PautaFinishParamns(pauta) );
  }

  void getListPautaOpen(){
    pautaOpenGetListCase.execute(_GetFindOpenUsecaseObserver(this), (){});
  }

  @override
  void dispose() {
    pautaFinishUseCase.dispose();
    pautaOpenGetListCase.dispose();

  }
}

class _GetFindOpenUsecaseObserver extends Observer<FindOpenUsecaseResponse> {

  PautaOpenPresenter presenter;


  _GetFindOpenUsecaseObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.getFindOpenUsecaseOnComplete != null);
    presenter.getFindOpenUsecaseOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.getFindOpenUsecaseOnError != null);
    presenter.getFindOpenUsecaseOnError(e);
  }

  @override
  void onNext(FindOpenUsecaseResponse response) {
    assert(presenter.getFindOpenUsecaseOnNext != null);
    presenter.getFindOpenUsecaseOnNext(response.list);
  }

}

class _GetPautaFisishObserver extends Observer<PautaFinishUseCaseResponse> {

  final PautaOpenPresenter presenter;


  _GetPautaFisishObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.getPautaFinishUseCaseOnComplete != null);
    presenter.getPautaFinishUseCaseOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.getPautaFinishUseCaseOnError != null);
    presenter.getPautaFinishUseCaseOnError(e);
  }

  @override
  void onNext(PautaFinishUseCaseResponse response) {
    assert(presenter.getPautaFinishUseCaseOnNext != null);
    presenter.getPautaFinishUseCaseOnNext(response.result);
  }
}