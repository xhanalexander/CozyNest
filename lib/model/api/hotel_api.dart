import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../hotel_model.dart';
import 'privates.dart';

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

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        List<HotelModel> hotels = data
            .map(
              (e) => HotelModel(
                name: e['name'],
                address: e['address'],
                description: e['description'],
              ),
            )
            .toList();

        // log(">> results =" + response.statusCode.toString());
        return hotels;
      } else {
        throw Exception('Failed to load hotels');
      }
    } catch (e) {
      throw Exception('Failed to load hotels: $e');
    }
  }
}