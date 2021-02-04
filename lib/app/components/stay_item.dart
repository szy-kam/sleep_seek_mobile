import 'package:flutter/material.dart';
import 'package:sleep_seek_mobile/app/pages/pages.dart';
import 'package:sleep_seek_mobile/app/utils/constants.dart';
import 'package:sleep_seek_mobile/domain/entities/stay.dart';

class StayItem extends StatelessWidget {
  final Stay stay;
  static const String seeMoreText = "Zobacz więcej";
  static const String fromText = "od";
  static const String currency = "zł";

  const StayItem(this.stay);

  @override
  Widget build(BuildContext context) {
    Image img = Image.asset(Resources.logo, width: 90, height: 80,);
    try {
      if (stay.mainPhoto != null && stay.mainPhoto.length > 0) {
        img = Image.network(
          stay.mainPhoto,
          height: 80,
          width: 90,
        );
      }
    } catch (e) {
      print(e);
    }
    Row body = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(child: img),
        Expanded(
          child: Container(
            child: Text(
              stay.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
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
      ],
    );
    Row footer = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              fromText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
            Text(
              stay.minPrice.toString(),
              style: TextStyle(
                color: UIConstants.buttonColor,
                fontSize: 20.0,
              ),
            ),
            Text(
              currency,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        Container(
            child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(Pages.stay_view, arguments: {"stayId": stay.id}),
          child: SizedBox(
            width: 120,
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(color: UIConstants.buttonColor),
              child: Center(
                child: Text(
                  seeMoreText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ),
        ))
      ],
    );

    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: Column(
        children: <Widget>[
          body,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on),
              Text(stay.address.city + ", " + stay.address.country),
            ],
          ),
          footer
        ],
      ),
    );
  }
}
