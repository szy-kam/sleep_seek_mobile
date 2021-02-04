import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sleep_seek_mobile/app/components/ensure_visible.dart';
import 'package:sleep_seek_mobile/app/components/input_field.dart';
import 'package:sleep_seek_mobile/app/pages/login/login_controller.dart';
import 'package:sleep_seek_mobile/app/utils/constants.dart';
import 'package:sleep_seek_mobile/data/repositories/data_authentication_repository.dart';

class LoginPage extends View {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginPageView createState() => LoginPageView();
}

class LoginPageView extends ViewState<LoginPage, LoginController> {
  static const String emailPrompt = 'Adres E-mail';
  static const String passwordPrompt = 'Hasło';
  static const String loginButtonText = 'Zaloguj się';
  static const String registerButtonText = 'Nie masz jeszcze konta? Zarejestruj się tutaj';

  final FocusNode _emailFocus;
  final FocusNode _passFocus;
  LoginController controller;

  factory LoginPageView() =>
      LoginPageView._internal(LoginController(DataAuthenticationRepository()));

  LoginPageView._internal(LoginController controller)
      : _emailFocus = FocusNode(),
        _passFocus = FocusNode(),
        super(controller) {
    this.controller = controller;
  }

  @override
  Widget buildPage() {
    return Scaffold(
        key: globalKey,
        appBar: appBar,
        body: ModalProgressHUD(
            child: body,
            inAsyncCall: controller.isLoading,
            color: UIConstants.progressBarColor,
            opacity: UIConstants.progressBarOpacity));
  }

  Stack get body => Stack(
        children: <Widget>[
          background,
          ListView(
            physics: PageScrollPhysics(),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 8,
                              bottom: 10.0),
                          child: Image(
                            image: AssetImage(Resources.logo),
                            width: 200.0,
                          ),
                        ),
                        Text(
                          UIConstants.loginText,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 8),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          emailField,
                          passwordField,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 45.0, vertical: 5.0),
                          ),
                          SizedBox(height: 40.0),
                          loginButton,
                          SizedBox(height: 20.0),
                          signUpButton
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
  AppBar get appBar => AppBar(
    backgroundColor: UIConstants.buttonColor,
    elevation: 0.0,
    centerTitle: true,

  );

  Widget get background => Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      height: MediaQuery.of(context).size.height,
      child: Container());


  Widget get emailField => EnsureVisibleWhenFocused(
      child: InputField(
        controller.emailTextController,
        emailPrompt,
        _emailFocus,
        type: TextInputType.emailAddress,
      ),
      focusNode: _emailFocus);

  Widget get passwordField => EnsureVisibleWhenFocused(
        child: InputField(
            controller.passwordTextController, passwordPrompt, _passFocus,
            isPassword: true),
        focusNode: _passFocus,
      );

  GestureDetector get loginButton => GestureDetector(
        onTap: () {
          controller.login();
        },
        child: Container(
          width: 320.0,
          height: 50.0,
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
              color: UIConstants.buttonColor,
              borderRadius: BorderRadius.circular(25.0)),
          child: Text(loginButtonText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.4)),
        ),
      );

  GestureDetector get signUpButton => GestureDetector(
        onTap: controller.signup,
        child: Text(
          registerButtonText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
      );

}
