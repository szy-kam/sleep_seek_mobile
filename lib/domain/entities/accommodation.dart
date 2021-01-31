import 'dart:convert';

class Accommodation {
  final int id;
  final int stayId;
  final int sleepersCapacity;
  final int quantity;
  final int price;
  final List<String> properties;

  Accommodation(this.id, this.stayId, this.sleepersCapacity, this.quantity,
      this.price, this.properties);

  Accommodation.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        stayId = map['stayId'],
        sleepersCapacity = map['sleepersCapacity'],
        quantity = map['quantity'],
        price = map['price'],
        properties = map['properties'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'stayId': stayId,
        'sleepersCapacity': sleepersCapacity,
        'quantity': quantity,
        'price': price,
        'properties': jsonEncode(properties)
      };

  Map<String, String> toJson2() => {
        'id': id.toString(),
        'stayId': stayId.toString(),
        'sleepersCapacity': sleepersCapacity.toString(),
        'quantity': quantity.toString(),
        'price': price.toString(),
        'properties': jsonEncode(properties)
      };
}
