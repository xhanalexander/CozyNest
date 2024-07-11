
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
  InnModel({
    required this.hotelId,
    required this.hotelName,
    required this.address,
    required this.max_1440PhotoUrl,
    required this.priceBreakdown,
  });
  late final int hotelId;
  late final String hotelName;
  late final String address;
  late final String max_1440PhotoUrl;
  late final PriceBreakdown priceBreakdown;
  
  InnModel.fromJson(Map<String, dynamic> json){
    hotelId = json['hotel_id'];
    hotelName = json['hotel_name'];
    address = json['address'];
    max_1440PhotoUrl = json['max_1440_photo_url'];
    priceBreakdown = PriceBreakdown.fromJson(json['price_breakdown']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hotel_id'] = hotelId;
    _data['hotel_name'] = hotelName;
    _data['address'] = address;
    _data['max_1440_photo_url'] = max_1440PhotoUrl;
    _data['price_breakdown'] = priceBreakdown.toJson();
    return _data;
  }
}

class PriceBreakdown {
  PriceBreakdown({
    required this.grossPrice,
    required this.currency,
  });
  late final double grossPrice;
  late final String currency;
  
  PriceBreakdown.fromJson(Map<String, dynamic> json){
    grossPrice = double.parse(json['gross_price'].toString());
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['gross_price'] = grossPrice;
    _data['currency'] = currency;
    return _data;
  }
}
