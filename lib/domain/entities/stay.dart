import 'dart:convert';

import 'dart:wasm';

class Stay {
  final int id;
  final String name;
  final String username;
  final String description;
  final String email;
  final String mainPhoto;
  final String category;
  final String createdAt;
  final int minPrice;
  String avgRate;
  final String phoneNumber;
  final List<String> photos;
  final List<String> properties;
  final Address address;

  Stay(
      this.id,
      this.name,
      this.username,
      this.description,
      this.email,
      this.mainPhoto,
      this.category,
      this.createdAt,
      this.avgRate,
      this.phoneNumber,
      this.photos,
      this.properties,
      this.address, this.minPrice);

  Stay.fromJson(Map<String, dynamic> map)
      : id = map['id'] as int,
        minPrice = map['minPrice'] as int,
        name = map['name'] as String,
        username = map['username'] as String,
        email = map['email'] as String,
        description = map['description'] as String,
        mainPhoto = map['mainPhoto'] as String,
        category = map['category'] as String,
        createdAt = map['createdAt'] as String,
        avgRate = map['avgRate'] as String,
        phoneNumber = map['phoneNumber'] as String,
        photos = List<String>.from(map['photos']),
        properties = List<String>.from(map['properties']),
        address = Address.fromJson(map['address']){
    if(avgRate == "0"){
      avgRate = "0,0";
    }
  }



  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'minPrice' : minPrice,
        'username': username,
        'email': email,
        'description': description,
        'mainPhoto': mainPhoto,
        'category': category,
        'createdAt': createdAt,
        'phoneNumber': phoneNumber,
        'photos': jsonEncode(photos),
        'properties': jsonEncode(properties),
        'address': address.toJson()
      };

  Map<String, String> toJson2() => {
        'id': id.toString(),
        'name': name,
        'username': username,
        'email': email,
        'minPrice' : minPrice.toString(),
        'description': description,
        'mainPhoto': mainPhoto,
        'category': category,
        'createdAt': createdAt,
        'phoneNumber': phoneNumber,
        'photos': jsonEncode(photos),
        'properties': jsonEncode(properties),
        'address': jsonEncode(address.toJson2())
      };
}

class Address {
  final String city;
  final String street;
  final String country;
  final String zipCode;
  final double longitude;
  final double latitude;

  Address(this.city, this.street, this.country, this.zipCode, this.longitude,
      this.latitude);

  Address.fromJson(Map<String, dynamic> map)
      : city = map['city'],
        street = map['street'],
        country = map['country'],
        zipCode = map['zipCode'],
        longitude = map['longitude'],
        latitude = map['latitude'];

  Map<String, dynamic> toJson() => {
        'city': city,
        'country': country,
        'street': street,
        'zipCode': zipCode,
        'latitude': latitude,
        'longitude': longitude
      };

  Map<String, String> toJson2() => {
        'city': city,
        'country': country,
        'street': street,
        'zipCode': zipCode,
        'latitude': latitude.toString(),
        'longitude': longitude.toString()
      };
}
