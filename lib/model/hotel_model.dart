class HotelModel {
  final int hotel_id;
  final String name;
  final String? address;
  final String hotel_description;
  final double? exact_class;

  HotelModel({
    required this.hotel_id,
    required this.name,
    this.address,
    required this.hotel_description,
    this.exact_class,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      hotel_id: json['hotel_id'],
      name: json['name'],
      address: json['address'],
      hotel_description: json['hotel_description'],
      exact_class: json['exact_class'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hotel_id': hotel_id,
      'name': name,
      'address': address,
      'hotel_description': hotel_description,
      'exact_class': exact_class,
    };
  }
  
}