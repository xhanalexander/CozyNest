import 'package:flutter/material.dart';
import '../model/api/hotel_api.dart';
import '../model/hotel_model.dart';

class HotelViewModel extends ChangeNotifier {


  List<HotelModel> _hotel = [];

  List<HotelModel> get hotel => _hotel;

  getAllHotel() async {
    final h = await HotelAPI.getHotels();
    _hotel = h;
    notifyListeners();
  }
  
}