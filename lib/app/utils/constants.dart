import 'package:flutter/material.dart';
import 'package:sleep_seek_mobile/app/pages/pages.dart';

class UIConstants {
  static const TextStyle fieldHintStyle =
  TextStyle(fontWeight: FontWeight.w300, color: Colors.black);
  static const String appName = "Sleep seek";
  static const double progressBarOpacity = 0.6;
  static const Color progressBarColor = Colors.black;
  static const Color buttonColor = Color(0xff18475E);

  static const String loginText = "Zaloguj się:";

  static const String displayNameRequired =
      "Nazwa wyświetlana jest obowiązkowa";
  static const String emailRequired = "E-mail jest wymagany";
  static const String passwordRequired = "Pole hasło jest wymagane";
  static const String repeatPasswordRequired =
      "Powtórzone hasło się nie zgadza";

  static const String signUpText = "Utwórz nowe konto";
}

PreferredSizeWidget CustomAppBar(BuildContext context) =>
    AppBar(
      backgroundColor: Colors.white38,
      actions: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
              child: Icon(Icons.home),
              onTap: () => Navigator.of(context).popAndPushNamed(Pages.home)),
        ),
        Padding(padding: EdgeInsets.all(8.0), child: GestureDetector(
            child: Icon(Icons.search),
            onTap: () => Navigator.of(context).pushNamed(Pages.search_basic))),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
              child: Icon(Icons.person),
              onTap: () => Navigator.of(context).pushNamed(Pages.login)),
        )
      ],
    );

class Resources {
  static const String logo = 'assets/img/logo.png';
}

void showGenericSnackbar(BuildContext context, String text,
    {bool isError = false}) {
  Scaffold.of(context).showSnackBar(_getGenericSnackbar(text, isError));
}

SnackBar _getGenericSnackbar(String text, bool isError) {
  return SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: isError ? Colors.red : Colors.white,
        fontSize: 16.0,
      ),
    ),
  );
}

Map<String, String> get StayPropertiesIconMap =>
    {
      "PARKING": 'assets/img/stay/properties/parking.png',
      "GYM": 'assets/img/stay/properties/gym.png',
      "POOL": 'assets/img/stay/properties/pool.png',
      "RESTAURANT": 'assets/img/stay/properties',
      "WIFI": 'assets/img/stay/properties/wifi.png',
      "RECEPTION24H": 'assets/img/stay/properties/reception_24h.png',
      "PETS_ALLOWED": 'assets/img/stay/properties/pets_allowed.png',
      "CARD_ACCEPTED": 'assets/img/stay/properties/card_payment.png',
      "DISABLED_ACCESSIBLE": 'assets/img/stay/properties/disabled_accessible.png',
      "BAR": 'assets/img/stay/properties/bar.png'
    };

Map<String, String> get StayPropertiesTextMap =>
    {
      "PARKING": 'Parking',
      "GYM": 'Siłownia',
      "POOL": 'Basen',
      "RESTAURANT": 'Restauracja',
      "WIFI": 'WIFI',
      "RECEPTION24H": 'Recepcja 24h',
      "PETS_ALLOWED": 'Przyjazny zwierzętom',
      "CARD_ACCEPTED": 'Akceptujemy płatności kartą',
      "DISABLED_ACCESSIBLE": 'Ułatwienia dla niepełnosprawnych',
      "BAR": 'Bar'
    };

enum StayProperties {
  PARKING,
  GYM,
  POOL,
  RESTAURANT,
  WIFI,
  RECEPTION24H,
  PETS_ALLOWED,
  CARD_ACCEPTED,
  DISABLED_ACCESSIBLE,
  BAR
}