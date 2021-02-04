import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
import 'package:sleep_seek_mobile/app/pages/home/home_presenter.dart';
import 'package:sleep_seek_mobile/domain/entities/stay.dart';
import 'package:sleep_seek_mobile/domain/entities/user.dart';

class HomeController extends Controller {
  HomePresenter _homePresenter;
  User _currentUser = User("", "");
  List<Stay> _recentlyAddedStays;

  User get currentUser => _currentUser;

  List<Stay> get recentlyAddedStays => _recentlyAddedStays;
  Logger logger;
  bool userRetrieved;
  bool staysRetrieved;
  bool isLoading;

  HomeController(authenticationRepository, staysRepository)
      : _homePresenter =
            HomePresenter(authenticationRepository, staysRepository) {
    isLoading = true;
    _recentlyAddedStays = [];
    userRetrieved = false;
    staysRetrieved = false;

    retrieveData();
    retrieveStays();
  }

  @override
  void initListeners() {
    _homePresenter.getUserOnNext = (User user) {
      dismissLoading();
      _currentUser = user;
    };

    _homePresenter.getUserOnError = (e) {
      dismissLoading();
      print(e);
    };

    _homePresenter.getUserOnComplete = () {
      userRetrieved = true;
      if (staysRetrieved) dismissLoading();
    };

    _homePresenter.getStaysByParametersOnComplete = () {
      staysRetrieved = true;
      if (userRetrieved) dismissLoading();
    };

    _homePresenter.getStaysByParametersOnError = (e) {
      dismissLoading();
      print(e);
    };

    _homePresenter.getStaysByParametersOnNext = (List<Stay> stays) {
      dismissLoading();
      _recentlyAddedStays = stays;
    };
  }

  void retrieveStays() {
    _homePresenter.getRecentStays();
  }

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }

  void retrieveData() {
    _homePresenter.getUser();
  }

  @override
  void dispose() {
    _homePresenter.dispose();
    super.dispose();
  }
}
