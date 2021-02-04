import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/app/pages/stay_search/stay_search_presenter.dart';
import 'package:sleep_seek_mobile/app/utils/constants.dart';
import 'package:sleep_seek_mobile/domain/entities/stay.dart';

class StaySearchController extends Controller {
  TextEditingController city;
  TextEditingController country;
  TextEditingController priceFrom;
  TextEditingController priceTo;
  TextEditingController sleepersCapacity;
  List<StayProperties> properties;
  int pageNumber = 0;
  List<Stay> stays;
  int pageSize = 10;

  StaySearchController(stayRepository)
      : _presenter = StaySearchPresenter(stayRepository) {
    city = new TextEditingController();
    country = new TextEditingController();
    priceFrom = new TextEditingController();
    priceTo = new TextEditingController();
    sleepersCapacity = new TextEditingController();
    properties = new List<StayProperties>();
    stays = new List<Stay>();
  }

  StaySearchPresenter _presenter;

  void search() {
    String cityStr = city == null ? null : city.text;
    String countryStr = country == null ? null : country.text;
    String priceFromStr = priceFrom == null ? null : priceFrom.text;
    String priceToStr = priceTo == null ? null : priceTo.text;
    _presenter.getStays(pageNumber, pageSize, cityStr, countryStr, null,
        priceFromStr, priceToStr);
    refreshUI();
  }

  @override
  void initListeners() {
    _presenter.getStaysByParametersOnNext = (r) {
      stays = r;
      if (stays != null && stays.length >= pageSize) {
        pageNumber += 1;
      }
      refreshUI();
    };

    _presenter.getStaysByParametersOnError = (e) {
      refreshUI();
    };

    _presenter.getStaysByParametersOnComplete = () {
      refreshUI();
    };
  }
}
