import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:sleep_seek_mobile/app/pages/stay/stay_controller.dart';
import 'package:sleep_seek_mobile/app/utils/constants.dart';
import 'package:sleep_seek_mobile/data/repositories/data_accommodation_repository.dart';
import 'package:sleep_seek_mobile/data/repositories/data_review_repository.dart';
import 'package:sleep_seek_mobile/data/repositories/data_stay_repository.dart';
import 'package:sleep_seek_mobile/domain/entities/accommodation.dart';
import 'package:sleep_seek_mobile/domain/entities/review.dart';
import 'package:sleep_seek_mobile/domain/entities/stay.dart';

class StayPage extends View {
  final int stayId;

  StayPage(this.stayId);

  @override
  State<StatefulWidget> createState() {
    return StayPageView(
        stayId,
        StayController(stayId, DataStayRepository(),
            DataAccommodationRepository(), DataReviewRepository()));
  }
}

class StayPageView extends ViewState<StayPage, StayController> {
  int stayId;

  static const String stayDescription = "Opis obiektu";

  static const String roomsText = "Pokoje";

  static const String roomsPrefix = "pokój ";
  static const String roomsSufix = "os";

  static const String priceFromText = "ceny od";

  static const String propertiesText = "Udogodnienia";

  static const String reviewsText = "Ostatnie opinie: ";

  StayPageView(this.stayId, StayController controller) : super(controller);

  @override
  Widget buildPage() {
    if (controller.stay != null) {
      Stay stay = controller.stay;
      Row header = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Image(
            image: AssetImage(Resources.logo),
            height: 80,
            width: 90,
          )),
          Expanded(
            child: Container(
              child: Text(
                stay.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: DecoratedBox(
                    child: Center(
                      child: Text(
                        stay.avgRate,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    decoration: BoxDecoration(color: UIConstants.buttonColor),
                  ),
                ),
              ),
              Text("Ocena obiektu")
            ],
          ),
        ],
      );
      Column photos = Column(
        children: getPhotos(stay.photos),
      );
      Row address = getAddress(stay.address);
      Row email = Row(children: [Icon(Icons.email), Text(stay.email)]);
      Row phoneNumber = Row(
        children: [Icon(Icons.phone), Text(stay.phoneNumber)],
      );
      Column properties = Column(
        children: getProperties(stay.properties),
      );

      return Scaffold(
          appBar: CustomAppBar(context),
          body: Container(
            padding: EdgeInsets.all(15),
            child: ListView(
              children: [
                header,
                photos,
                address,
                email,
                phoneNumber,
                Center(
                    child: Text(
                  stayDescription,
                  style: TextStyle(fontSize: 19),
                )),
                Text(stay.description),
                properties,
                getAccommodations(),
                getReviews()
              ],
            ),
          ));
    } else {
      return Scaffold(
          appBar: CustomAppBar(context),
          body: Center(
            child: ListView(
              children: [],
            ),
          ));
    }
  }

  List<Widget> getPhotos(List<String> photos) {
    List<Widget> widgets = List<Widget>();
    for (int i = 0; i < photos.length; i += 2) {
      List<Widget> imageRow = List<Widget>();
      try {
        imageRow.add(Image.network(
          photos[i],
          width: 150,
          height: 150,
        ));
      } catch (e) {
        print(e);
      }
      if (i + 1 != photos.length) {
        try {
          imageRow.add(Image.network(
            photos[i + 1],
            width: 150,
            height: 150,
          ));
        } catch (e) {
          print(e);
        }
      }
      Row row = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: imageRow,
      );
      widgets.add(Container(
        child: row,
      ));
    }
    return widgets;
  }

  Row getAddress(Address address) {
    return Row(
      children: <Widget>[
        Icon(Icons.location_on),
        Text(
          address.street +
              ', ' +
              address.city +
              ', ' +
              address.zipCode +
              ', ' +
              address.country,
          style: TextStyle(fontSize: 12),
        )
      ],
    );
  }

  List<Widget> getProperties(List<String> properties) {
    List<Widget> widgets = List<Widget>();
    widgets.add(Text(
      propertiesText,
      style: TextStyle(fontSize: 18),
    ));
    for (String prop in properties) {
      if (prop == "RESTAURANT") {
        widgets.add(Row(children: [
          Icon(Icons.restaurant),
          Text(StayPropertiesTextMap[prop])
        ]));
      } else if (prop == "BAR") {
        widgets.add(Row(children: [
          Icon(Icons.local_drink),
          Text(StayPropertiesTextMap[prop])
        ]));
      } else {
        widgets.add(Row(
          children: [
            Image.asset(
              StayPropertiesIconMap[prop],
              width: 24,
              height: 24,
            ),
            Text(StayPropertiesTextMap[prop])
          ],
        ));
      }
    }
    return widgets;
  }

  Column getAccommodations() {
    List<Accommodation> accommodations = controller.accommodations;
    List<Widget> widgets = List<Widget>();
    widgets.add(Text(
      roomsText,
      style: TextStyle(fontSize: 18),
    ));
    for (Accommodation a in accommodations) {
      widgets.add(Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(4.0),
        decoration:
            BoxDecoration(border: Border.all(color: UIConstants.buttonColor)),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(right: 5, left: 5),
                child: Text(
                    roomsPrefix + a.sleepersCapacity.toString() + roomsSufix)),
            Text(priceFromText + " " + a.price.toString() + " zł"),
          ],
        ),
      ));
    }

    return Column(
      children: widgets,
    );
  }

  Widget getReviews() {
    List<Review> reviews = controller.reviews;
    List<Widget> widgets = List<Widget>();
    widgets.add(Text(
      reviewsText,
      style: TextStyle(fontSize: 18),
    ));
    if(controller.reviews == null){
      return Column(children: widgets,);
    }
    for (Review r in reviews) {
      print(r.createdAt);
      widgets.add(Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(4.0),
        decoration:
            BoxDecoration(border: Border.all(color: UIConstants.buttonColor)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Icon(Icons.person),
              Text(r.username),
              Text(r.rating.toString()+ "/5"),
            ]),
            Text(r.message)
          ],
        ),
      ));
    }
    return Column(
      children: widgets,
    );
  }
}
