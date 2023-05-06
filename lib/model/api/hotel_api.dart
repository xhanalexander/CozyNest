import 'dart:convert';
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
        queryParameters: {
          'exact_class': '5',
        },
        options: Options(
          headers: {
            'X-RapidAPI-Key': API_KEY,
            'X-RapidAPI-Host': 'booking-com.p.rapidapi.com',
          },
        ),
      );

      if (response.statusCode == 200) {
        final datas = response.data['result'];
        List<HotelModel> hotels = List<HotelModel>.from(datas.map((model) => HotelModel.fromJson(model)));
        return hotels;
      } else {
        throw Exception('Failed to load hotels');
      }
    } catch (e) {
      throw Exception('Failed to load hotels: $e');
    }
  }
}

class innAPi {
  static const String URL_inn = 'https://booking-com.p.rapidapi.com/v1/hotels/search';

  static Future<List<InnModel>> getSearchinn({required String checkin, required String checkout, required String ordersBy}) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        URL_inn,
        queryParameters: {
          'checkin_date': checkin,
          'dest_type': 'country',
          'units': 'metric',
          'checkout_date': checkout,
          'adults_number': 2,
          'order_by': ordersBy,
          'dest_id': 128,
          'filter_by_currency': 'IDR',
          'locale': 'id',
          'room_number': 1,
        },
        options: Options(
          headers: {
            'X-RapidAPI-Key': API_KEY,
            'X-RapidAPI-Host': 'booking-com.p.rapidapi.com',
          },
        ),
      );

      // log('response: ${response.data}');
      
      if (response.statusCode == 200) {
        final datas = response.data['result'];
        // log('>>> results' + datas.toString() );
        List<InnModel> inns = List<InnModel>.from(datas.map((model) {
          // log('>>> model =' + model['price_breakdown'].toString() );
          InnModel x = InnModel.fromJson(model);
          // log('>>> model =' + x.priceBreakdown.toString());
          return x;
        }));
        // log(inns.toString());
        /* log('>>> RESULT inn hotel name = ${inns[0].hotelName}');
        log('>>> RESULT inn hotel address = ${inns[0].address}');
        log('>>> RESULT inn hotel currency = ${inns[0].priceBreakdown.currency}');
        log('>>> RESULT inn hotel price = ${inns[0].priceBreakdown.grossPrice}');
        log('>>> RESULT inn hotel photo = ${inns[0].max_1440PhotoUrl}'); */
        return inns;
      } else {
        throw Exception('Failed to load Inn');
      }
    } catch (e) {
      throw Exception('Failed to load Inn: $e');
    }
  }
}