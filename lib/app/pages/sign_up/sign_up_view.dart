import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/app/pages/sign_up/sign_up_controller.dart';
import 'package:sleep_seek_mobile/app/utils/constants.dart';
import 'package:sleep_seek_mobile/data/repositories/data_authentication_repository.dart';

class SignUpPage extends View {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _SignUpPageView();
  }
}

class _SignUpPageView extends ViewState<SignUpPage, SignUpController> {
  static const String emailPrompt = 'Adres E-mail';
  static const String displayNamePrompt = 'Nazwa użytkownika';
  static const String passwordPrompt = 'Hasło';
  static const String confirmedPasswordPrompt = 'Powtórz hasło';
  static const String signUpButtonText = 'Zarejestruj się';
  static const String termsOSText =
      'Akceptuję regulamin i politykę prywatności';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const String loginButtonText = "Masz już konto? Zaloguj się tutaj";

  _SignUpPageView() : super(SignUpController(DataAuthenticationRepository()));

  @override
  Widget buildPage() {
    return Scaffold(
      key: globalKey,
      appBar: appBar,
      body: Stack(
        children: <Widget>[
          ListView(
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
                      UIConstants.signUpText,
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
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: controller.displayName,
                        decoration: InputDecoration(
                          hintText: displayNamePrompt,
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return UIConstants.displayNameRequired;
                          }
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: controller.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: emailPrompt,
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return UIConstants.emailRequired;
                          }
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: controller.password,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: passwordPrompt,
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return UIConstants.passwordRequired;
                          }
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: controller.confirmedPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: confirmedPasswordPrompt,
                        ),
                        validator: (String value) {
                          if (value.trim().isEmpty ||
                              controller.confirmedPassword.text !=
                                  controller.password.text) {
                            return UIConstants.repeatPasswordRequired;
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CheckboxListTile(
                              title: GestureDetector(
                                  onTap: () => controller.setAgreedToTOS(),
                                  child: Text(termsOSText)),
                              value: controller.agreedToTOS,
                              onChanged: (state) {
                                controller.setAgreedToTOS();
                              },
                              activeColor: Colors.red,
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () => controller.checkForm({
                              'context': context,
                              'formKey': _formKey,
                              'globalKey': globalKey
                            }),
                            child: Container(
                              width: 320.0,
                              height: 50.0,
                              alignment: FractionalOffset.center,
                              decoration: new BoxDecoration(
                                color: UIConstants.buttonColor,
                              ),
                              child: new Text(signUpButtonText,
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.4)),
                            ),
                          ),
                        ],
                      ),
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
    );
  }

  AppBar get appBar => AppBar(
        backgroundColor: UIConstants.buttonColor,
        elevation: 0.0,
        centerTitle: true,
      );

  GestureDetector get signUpButton => GestureDetector(
        onTap: controller.login,
        child: Text(
          loginButtonText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
      );
}
