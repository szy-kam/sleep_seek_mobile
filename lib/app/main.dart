import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:sleep_seek_mobile/app/pages/home/home_view.dart';
import 'package:sleep_seek_mobile/app/utils/router.dart' as sleep_seek_router;
import 'package:sleep_seek_mobile/data/exceptions/api_exception.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final sleep_seek_router.Router _router;

  MyApp() : _router = sleep_seek_router.Router() {
    initLogger();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black38));

    return MaterialApp(
      title: "SleepSeek",
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Color(0xff18475E),
        primarySwatch: Colors.blue,
        fontFamily: "Roboto" ,
        textTheme: TextTheme(
            headline1: TextStyle(color: Colors.black),
            bodyText1: TextStyle(color: Colors.black)),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(15.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide:
                  BorderSide(color: Color.fromRGBO(255, 255, 255, 0.4))),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide:
                  BorderSide(color: Color.fromRGBO(255, 255, 255, 0.4))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Color.fromRGBO(230, 38, 39, 0.8))),
          fillColor: Color.fromRGBO(255, 255, 255, 0.4),
          filled: true,
          hintStyle:
              TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
    );
  }

  void initLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      dynamic e = record.error;
      String m = e is APIException ? e.message : e.toString();
      print(
          '${record.loggerName}: ${record.level.name}: ${record.message} ${m != 'null' ? m : ''}');
    });
    Logger.root.info("Logger initialized.");
  }
}
