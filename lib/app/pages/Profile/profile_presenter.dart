import 'package:UDSApp/domain/usecases/profile_signout.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/usecases/profile_usecase.dart';

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
    signOutUseCase.execute(_GetSignOutPresenterObserver(this), (){});
  }

}

class _GetSignOutPresenterObserver extends Observer<SignOutResponse> {

  ProfilePresenter presenter;


  _GetSignOutPresenterObserver(this.presenter);

  @override
  void onComplete() {
    assert(presenter.signOutUseCaseOnComplete != null);
    presenter.signOutUseCaseOnComplete();
  }

  @override
  void onError(e) {
   assert(presenter.signOutUseCaseOnErro != null);
   presenter.signOutUseCaseOnErro(e);
  }

  @override
  void onNext(SignOutResponse response) {
   assert(presenter.signOutUseCaseOnNext != null);
   presenter.signOutUseCaseOnNext(response.response);
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