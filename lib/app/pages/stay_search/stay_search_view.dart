import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/app/components/stay_list.dart';
import 'package:sleep_seek_mobile/app/pages/stay_search/stay_search_controller.dart';
import 'package:sleep_seek_mobile/app/utils/constants.dart';
import 'package:sleep_seek_mobile/data/repositories/data_stay_repository.dart';

class StaySearchPage extends View {
  StaySearchPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StaySearchPageView(StaySearchController(DataStayRepository()));
  }
}

class StaySearchPageView
    extends ViewState<StaySearchPage, StaySearchController> {
  static const String countryPrompt = "Kraj";
  static const String cityPrompt = "Miasto";
  static const String pricePrompt = "Cena za dobę";
  static const String priceFromPrompt = "od";
  static const String priceToPrompt = "do";
  static const String sleepersCapacityPrompt = "liczba osób";
  static const String searchText = "Wyszukiwanie noclegu:";
  static const String searchTextBtn = "Szukaj";

  StaySearchPageView(StaySearchController controller) : super(controller);

  @override
  Widget buildPage() {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: getBody(),
    );
  }

  Widget getBody() {
    Widget header = Row(
      children: [
        Image.asset(
          Resources.logo,
          width: 90,
          height: 80,
        ),
        Text(
          searchText,
          style: TextStyle(color: UIConstants.buttonColor, fontSize: 20),
        )
      ],
    );
    Widget country() => TextFormField(
        controller: controller.country,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: countryPrompt,
        ));
    Widget city() => TextFormField(
        controller: controller.city,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: cityPrompt,
        ));
    Widget priceFrom = TextFormField(
        controller: controller.priceFrom,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: priceFromPrompt,
        ));

    Widget priceTo = TextFormField(
        controller: controller.priceTo,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: priceToPrompt,
        ));
    Widget sleepersCapacity() => TextFormField(
        controller: controller.sleepersCapacity,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: sleepersCapacityPrompt,
        ));
    Widget stays;
    if (controller.stays != null) {
      stays = StayList(controller.stays);
    } else {
      stays = Text("Brak wyników");
    }

    return ListView(
      children: [
        header,
        country(),
        city(),
        sleepersCapacity(),
        Text(
          pricePrompt,
          style: TextStyle(fontSize: 16),
        ),
        priceFrom,
        priceTo,
        SizedBox(
          width: 100,
          height: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(color: UIConstants.buttonColor),
            child: GestureDetector(
              onTap: controller.search,
              child: Center(
                child: Text(
                  searchTextBtn,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        stays
      ],
    );
  }
}
