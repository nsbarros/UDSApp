import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/domain/usecases/sign_up_usecase.dart';

class SignUpPresenter extends Presenter {

  Function getSingUpOnNext;
  Function getSingUpOnComplete;
  Function getSingUpOnError;

  SignUpUseCase signUpUseCase;

  SignUpPresenter(repository) : signUpUseCase = SignUpUseCase(repository);

  @override
  void dispose() {
    signUpUseCase.dispose();
  }

  void signUp(String email, String password, String name){
    signUpUseCase.execute(_GetSignUpObserver(this), SignUpUseCaseParams(email, password, name));
  }

}

class _GetSignUpObserver extends Observer<SignUpUseCaseResponde> {

  SignUpPresenter presenter;

  _GetSignUpObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.getSingUpOnComplete != null);
    presenter.getSingUpOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.getSingUpOnError != null);
    presenter.getSingUpOnError(e);
  }

  @override
  void onNext(SignUpUseCaseResponde response) {
    assert(presenter.getSingUpOnNext != null);
    presenter.getSingUpOnNext(response.mResult);
  }
}