import 'dart:convert';

class Reservation {
  final int id;
  final int accommodationId;
  final int stayId;
  final Customer customer;
  final String dateFrom;
  final String dateTo;
  final String createdAt;
  final bool confirmed;
  final bool completed;

  Reservation(
      this.id,
      this.accommodationId,
      this.stayId,
      this.customer,
      this.dateFrom,
      this.dateTo,
      this.createdAt,
      this.confirmed,
      this.completed);

  Reservation.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        accommodationId = map['accommodationId'],
        stayId = map['stayId'],
        customer = map['customer'],
        dateFrom = map['dateFrom'],
        dateTo = map['dateTo'],
        createdAt = map['createdAt'],
        confirmed = map['confirmed'],
        completed = map['completed'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'accommodationId': accommodationId,
        'stayId': stayId,
        'customer': customer.toJson(),
        'dateFrom': dateFrom,
        'dateTo': dateTo,
        'createdAt': createdAt,
        'confirmed': confirmed,
        'completed': completed
      };

  Map<String, String> toJson2() => {
        'id': id.toString(),
        'accommodationId': accommodationId.toString(),
        'stayId': stayId.toString(),
        'customer': jsonEncode(customer.toJson()),
        'dateFrom': dateFrom,
        'dateTo': dateTo,
        'createdAt': createdAt,
        'confirmed': confirmed.toString(),
        'completed': completed.toString()
      };
}

class Customer {
  final String fullName;
  final String username;
  final String phoneNumber;

  Customer(this.fullName, this.username, this.phoneNumber);

  Customer.fromJson(Map<String, dynamic> map)
      : fullName = map['fullName'],
        username = map['username'],
        phoneNumber = map['phoneNumber'];

  Map<String, dynamic> toJson() =>
      {'fullName': fullName, 'username': username, 'phoneNumber': phoneNumber};

  Map<String, String> toJson2() =>
      {'fullName': fullName, 'username': username, 'phoneNumber': phoneNumber};
}
