class HotelModel {
  final int hotel_id;
  final String name;
  final String? address;
  final String hotel_description;
  final String? photo;
  final double? exact_class;

  HotelModel({
    required this.hotel_id,
    required this.name,
    this.address,
    required this.hotel_description,
    this.photo,
    this.exact_class,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      hotel_id: json['hotel_id'],
      name: json['name'],
      address: json['address'],
      hotel_description: json['hotel_description'],
      photo: json['max_1440_photo_url'],
      exact_class: json['exact_class'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hotel_id': hotel_id,
      'name': name,
      'address': address,
      'hotel_description': hotel_description,
      'max_1440_photo_url': photo,
      'exact_class': exact_class,
    };
  }
}

/// Inn Model

class InnModel {
  final int hotel_id;
  final String hotel_name;
  final String? address;
  final int gross_price;
  final String? max_1440_photo_url;
  final String details;

  InnModel({
    required this.hotel_id,
    required this.hotel_name,
    this.address,
    required this.gross_price,
    this.max_1440_photo_url,
    required this.details,
  });

  factory InnModel.fromJson(Map<String, dynamic> json) {
    return InnModel(
      hotel_id: json['hotel_id'],
      hotel_name: json['hotel_name'],
      address: json['address'],
      gross_price: json['gross_price'],
      max_1440_photo_url: json['max_1440_photo_url'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hotel_id': hotel_id,
      'hotel_name': hotel_name,
      'address': address,
      'gross_price': gross_price,
      'max_1440_photo_url': max_1440_photo_url,
      'details': details,
    };
  }
}