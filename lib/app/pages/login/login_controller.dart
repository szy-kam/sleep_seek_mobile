import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/app/pages/login/login_presenter.dart';
import 'package:sleep_seek_mobile/app/pages/pages.dart';
import 'package:sleep_seek_mobile/app/utils/constants.dart';

class LoginController extends Controller {
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  bool isLoading;
  LoginPresenter _loginPresenter;


  LoginController(authRepo) : _loginPresenter = LoginPresenter(authRepo) {
    isLoading = false;
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    initListeners();
  }

  void initListeners() {
    _loginPresenter.loginOnComplete = this._loginOnComplete;
    _loginPresenter.loginOnError = this._loginOnError;
  }

  void _loginOnComplete() {
    dismissLoading();
    Navigator.of(getContext()).popAndPushNamed(Pages.home);
  }

  void _loginOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message, isError: true);
  }

  void login() async {
    isLoading = true;
    _loginPresenter.login(
        email: emailTextController.text, password: passwordTextController.text);
    refreshUI();
  }

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }

  void signup() {
    Navigator.of(getContext()).popAndPushNamed(Pages.signup);
  }
}
