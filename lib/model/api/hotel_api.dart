import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'privates.dart';
import '../hotel_model.dart';

class HotelAPI {
  static const String _BASE_URL = 'https://booking-com.p.rapidapi.com/v1/static/hotels';

  static Future<List<HotelModel>> getAllHotel() async {
    final dio = Dio();
    try {
      final response = await dio.get(
        _BASE_URL,
        options: Options(
          headers: {
            'X-RapidAPI-Key': API_KEY,
            'X-RapidAPI-Host': 'booking-com.p.rapidapi.com',
          },
        ),
      );

      // log(">> results = " + response.statusCode.toString());

      if (response.statusCode == 200) {
        final datas = response.data['result'];
        // log(">> hasil =" + datas.toString());
        List<HotelModel> hotels = List<HotelModel>.from(datas.map((model) => HotelModel.fromJson(model)));
        // log(">> results =" + hotels[0].name);
        return hotels;
      } else {
        throw Exception('Failed to load hotels');
      }
    } catch (e) {
      // log(e.toString());
      throw Exception('Failed to load hotels: $e');
    }
  }
  
}