import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/domain/usecases/login_user_usecase.dart';

class HomePresenter extends Presenter {

  Function getUserOnNext;
  Function getUserOnComplete;
  Function getUserOnError;

  LoginUseCase loginUseCase;


  HomePresenter(repository){
    loginUseCase = LoginUseCase(repository);
  }

  void logIn(String email, String password){
    loginUseCase.execute(_getLoginUseCaseObserver(this), LoginUseCaseParams(email, password));
  }

  @override
  void dispose() {
    loginUseCase.dispose();
  }

}

class _getLoginUseCaseObserver extends Observer<LoginUseCaseResponde> {

  final HomePresenter presenter;

  _getLoginUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.getUserOnComplete != null);
    presenter.getUserOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.getUserOnError != null);
    presenter.getUserOnError(e);
  }

  @override
  void onNext(response) {
    assert(presenter.getUserOnNext != null);
    presenter.getUserOnNext(response.result);
  }
}