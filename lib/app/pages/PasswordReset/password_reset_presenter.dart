import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/domain/usecases/password_reset_usecase.dart';

class PasswordResetPresenter extends Presenter{

  Function getPasswordResetOnNext;
  Function getPasswordResetOnComplete;
  Function getPasswordResetOnError;

  PasswordResetUseCase passwordResetUseCase;


  PasswordResetPresenter(repository): passwordResetUseCase = PasswordResetUseCase(repository);

  void resetPassword(String email){
    passwordResetUseCase.execute(_GetPasswordObserver(this), PasswordResetParams(email));
  }

  @override
  void dispose() {
    passwordResetUseCase.dispose();
  }

}

class _GetPasswordObserver extends Observer<PasswordResetUseCaseResponse> {

  PasswordResetPresenter presenter;

  _GetPasswordObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.getPasswordResetOnComplete != null);
    presenter.getPasswordResetOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.getPasswordResetOnError != null);
    presenter.getPasswordResetOnError(e);
  }

  @override
  void onNext(PasswordResetUseCaseResponse response) {
    assert(presenter.getPasswordResetOnNext != null);
    presenter.getPasswordResetOnNext(response.response);
  }
}