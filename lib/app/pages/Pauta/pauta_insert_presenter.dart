import 'package:UDSApp/domain/entities/pauta.dart';
import 'package:UDSApp/domain/usecases/pauta_get_user_usecase.dart';
import 'package:UDSApp/domain/usecases/pauta_insert_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class PautaInsertPresenter extends Presenter{

  PautaInsertUseCase insertUseCase;
  GetUserUseCase getUserUseCase;

  Function getUserNext;
  Function getUserError;
  Function getUserComplete;

  Function insertPautaNext;
  Function insertPautaError;
  Function insertPautaComplete;

  PautaInsertPresenter(repository) : insertUseCase = PautaInsertUseCase(repository),
        getUserUseCase = GetUserUseCase(repository);

  @override
  void dispose() {
    insertUseCase.dispose();
    getUserUseCase.dispose();
  }

  void add(Pauta pauta){
    insertUseCase.execute(_GetPautaInsertObserver(this), PautaInsertUseCaseParams(pauta));
  }

  void getUser(){
    getUserUseCase.execute(_GetUserObserver(this), (){});
  }
}

class _GetUserObserver extends Observer<GetUserUseCaseResponse> {

  PautaInsertPresenter presenter;

  _GetUserObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.getUserComplete != null);
    presenter.getUserComplete();
  }

  @override
  void onError(e) {
   assert(presenter.getUserError != null);
   presenter.getUserError(e);
  }

  @override
  void onNext(GetUserUseCaseResponse response) {
    assert(presenter.getUserNext != null);
    presenter.getUserNext(response.user);
  }
}

class _GetPautaInsertObserver extends Observer<PautaInsertUseCaseResponse> {

  PautaInsertPresenter presenter;

  _GetPautaInsertObserver(this.presenter);

  @override
  void onComplete() {
   assert(presenter.insertPautaComplete != null);
   presenter.insertPautaComplete();
  }

  @override
  void onError(e) {
    assert(presenter.insertPautaError != null);
    presenter.insertPautaError(e);
  }

  @override
  void onNext(PautaInsertUseCaseResponse response) {
    assert(presenter.insertPautaNext != null);
    presenter.insertPautaNext(response.mensagem);
  }
}