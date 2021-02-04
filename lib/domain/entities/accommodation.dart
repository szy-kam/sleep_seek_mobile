import 'dart:convert';

import 'dart:io';

class Accommodation {
  final int id;
  final int stayId;
  final int sleepersCapacity;
  final int quantity;
  final int price;
  final List<String> properties;
  final String prefix;
  final bool reservable;

  Accommodation(this.id, this.stayId, this.sleepersCapacity, this.quantity,
      this.price, this.properties, this.prefix, this.reservable);

  Accommodation.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        stayId = map['stayId'],
        sleepersCapacity = map['sleepersCapacity'],
        quantity = map['quantity'],
        price = map['price'],
        properties = List<String>.from(map['properties']),
        prefix = map['prefix'],
        reservable = map['reservable'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'stayId': stayId,
        'prefix' : prefix,
        'sleepersCapacity': sleepersCapacity,
        'quantity': quantity,
        'price': price,
        'properties': jsonEncode(properties),
        'reservable': reservable
      };

  Map<String, String> toJson2() => {
        'id': id.toString(),
        'stayId': stayId.toString(),
        'sleepersCapacity': sleepersCapacity.toString(),
        'quantity': quantity.toString(),
        'price': price.toString(),
        'properties': jsonEncode(properties),
        'reservable': jsonEncode(reservable)
      };
}
