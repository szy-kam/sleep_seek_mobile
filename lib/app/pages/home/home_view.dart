import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sleep_seek_mobile/app/components/stay_list.dart';
import 'package:sleep_seek_mobile/app/pages/home/home_controller.dart';
import 'package:sleep_seek_mobile/app/utils/constants.dart';
import 'package:sleep_seek_mobile/data/repositories/data_authentication_repository.dart';
import 'package:sleep_seek_mobile/data/repositories/data_stay_repository.dart';

class HomePage extends View {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageView createState() => _HomePageView();
}

class _HomePageView extends ViewState<HomePage, HomeController> {
  _HomePageView()
      : super(HomeController(
            DataAuthenticationRepository(), DataStayRepository()));

  @override
  Widget buildPage() {
    return Scaffold(
      key: globalKey,
      appBar: CustomAppBar(context),
      body: ModalProgressHUD(
          child: getbody(),
          inAsyncCall: controller.isLoading,
          opacity: UIConstants.progressBarOpacity,
          color: UIConstants.progressBarColor),
    );
  }

  Widget getbody() {
    List<Widget> children = controller.recentlyAddedStays.isNotEmpty
        ? [
            SizedBox(height: 10.0),
            logoContainer,
            SizedBox(height: 10.0),
            Center(
              child: Text(
                "Ostatnio dodane",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            SizedBox(height: 60.0),
            StayList(controller.recentlyAddedStays),
          ]
        : [
            SizedBox(height: 60.0),
            logoContainer,
          ];

    return ListView(children: children);
  }

  Container get logoContainer => Container(
        width: double.infinity,
        height: 100.0,
        child: Image(
          image: AssetImage(Resources.logo),
          width: 100.0,
        ),
      );
}
