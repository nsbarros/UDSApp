import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uds_app/domain/usecases/profile_signout.dart';

import '../../../domain/usecases/profile_usecase.dart';
import '../SignUp/signup_presenter.dart';

class ProfilePresenter extends Presenter{

  ProfileUseCase profileUseCase;
  SignOut signOutUseCase;

  Function signOutUseCaseOnNext;
  Function signOutUseCaseOnErro;
  Function signOutUseCaseOnComplete;
  
  Function profilePresenterOnNext;
  Function profilePresenterOnErro;
  Function profilePresenterOnComplete;

  ProfilePresenter(repository) : profileUseCase = ProfileUseCase(repository),
        signOutUseCase = SignOut(repository);

  void getUser(){
    profileUseCase.execute(_GetProfilePresenterObserver(this), (){} );
  }

  @override
  void dispose() {
    profileUseCase.dispose();
  }

  void signOut(){
    signOutUseCase.execute(_GetSignOutPresenterObserver(), (){});
  }

}

class _GetSignOutPresenterObserver extends Observer<SignOutResponse>{
  
  SignUpPresenter presenter;
  
  @override
  void onComplete() {
    assert(presenter.getSingUpOnComplete() != null);
    presenter.getSingUpOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.getSingUpOnError() != null);
    presenter.getSingUpOnError(e);
  }

  @override
  void onNext(SignOutResponse response) {
    assert(presenter.getSingUpOnNext(response.response));
  } 
}

class _GetProfilePresenterObserver extends Observer<ProfileUseCaseResponse> {

  ProfilePresenter presenter;


  _GetProfilePresenterObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.profilePresenterOnComplete != null);
    presenter.profilePresenterOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.profilePresenterOnErro != null);
    presenter.profilePresenterOnErro(e);
  }

  @override
  void onNext(ProfileUseCaseResponse response) {
    assert(presenter.profilePresenterOnNext != null);
    presenter.profilePresenterOnNext(response.user);
  }
}