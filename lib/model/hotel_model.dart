class HotelModel {
  final String name;
  final String address;
  final String description;
  // final String image;
  // final String rating;


  HotelModel({
    required this.name,
    required this.address,
    required this.description,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      name: json['name'],
      address: json['address'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'description': description,
    };
  }
  
}