import 'package:flutter/material.dart';
import 'package:sleep_seek_mobile/app/components/stay_item.dart';
import 'package:sleep_seek_mobile/domain/entities/stay.dart';

class StayList extends StatelessWidget {
  final List<Stay> stays;

  StayList(this.stays);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List<Widget>();
    List<StayItem> stayItems = stays.map((e) => StayItem(e)).toList();
    for (StayItem item in stayItems) {
      widgets.add(Center(child: item));
    }
    return Column(
      children: widgets,
    );
  }
}