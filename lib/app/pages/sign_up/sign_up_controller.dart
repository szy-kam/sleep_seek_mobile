import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/app/pages/sign_up/sign_up_presenter.dart';
import 'package:sleep_seek_mobile/app/utils/constants.dart';

class SignUpController extends Controller {
  TextEditingController email;
  TextEditingController password;
  TextEditingController confirmedPassword;
  TextEditingController displayName;
  bool isLoading;
  SignUpPresenter _signUpPresenter;

  bool agreedToTOS;
  SignUpController(authRepo) : _signUpPresenter = SignUpPresenter(authRepo) {
    isLoading = false;
    email = TextEditingController();
    password = TextEditingController();
    confirmedPassword = TextEditingController();
    displayName = TextEditingController();
    agreedToTOS = false;
    initListeners();
  }


  @override
  void initListeners() {
    _signUpPresenter.signUpOnError = this._signUpOnError;
    _signUpPresenter.signUpOnComplete = this._signUpOnComplete;
  }

  void _signUpOnComplete() {
    dismissLoading();
    Navigator.of(getContext()).popAndPushNamed('/login');
  }

  void _signUpOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message, isError: true);
  }

  void signup() async {
    isLoading = true;
    refreshUI();
    _signUpPresenter.signUp(
        email: email.text,
        password: password.text,
        displayName: displayName.text);
  }

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }

  void login() {
    Navigator.of(getContext()).popAndPushNamed('/login');
  }

  void checkForm(Map<String, Object> map) {}

  void setAgreedToTOS() {
    agreedToTOS = !agreedToTOS;
    refreshUI();
  }
}
