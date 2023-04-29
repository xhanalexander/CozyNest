class HotelModel {
  final String name;
  final String? address;
  final String hotel_description;
  final double? exact_class;

  HotelModel({
    required this.name,
    this.address,
    required this.hotel_description,
    this.exact_class,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      name: json['name'],
      address: json['address'],
      hotel_description: json['hotel_description'],
      exact_class: json['exact_class'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'hotel_description': hotel_description,
      'exact_class': exact_class,
    };
  }
  
}