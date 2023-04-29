import 'dart:developer';
import 'package:flutter/material.dart';
import '../../model/api/hotel_api.dart';
import '../../model/hotel_model.dart';

enum HotelState { initial, loading, loaded, error }

class HotelViewModel extends ChangeNotifier {
  List<HotelModel> _hotels = [];
  HotelState _state = HotelState.initial;

  List<HotelModel> get hotels => _hotels;
  
  HotelState get state => _state;

  getHotels() async {
    _state = HotelState.loading;

    try {
      final hotels = await HotelAPI.getAllHotel();
      _hotels = hotels;
      _state = HotelState.loaded;
    } catch (e) {
      _state = HotelState.error;
    }
    notifyListeners();
    // log(">> results =" + hotels[0].name);

  }
  
}