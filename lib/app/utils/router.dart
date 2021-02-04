import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sleep_seek_mobile/app/pages/pages.dart';
import 'package:sleep_seek_mobile/app/pages/review/review_view.dart';
import 'package:sleep_seek_mobile/app/pages/stay/stay_view.dart';
import 'package:sleep_seek_mobile/app/pages/stay_search/stay_search_view.dart';

class Router {
  final RouteObserver<PageRoute> routeObserver;

  Router() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.home:
        return _buildRoute(settings, HomePage());
      case Pages.login:
        return _buildRoute(settings, LoginPage());
      case Pages.signup:
        return _buildRoute(settings, SignUpPage());
      case Pages.search_basic:
        return _buildRoute(settings, StaySearchPage());
      case Pages.add_review:
        return _buildRoute(settings, ReviewPage());
      case Pages.stay_view:
        Map<String, dynamic> args = settings.arguments as Map;
        return _buildRoute(settings, StayPage(args['stayId']));
      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}
