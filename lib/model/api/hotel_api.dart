import 'dart:developer';

import 'package:dio/dio.dart';
import '../hotel_model.dart';

class HotelAPI {

  static Future<List<HotelModel>> getHotels() async {

    final response = await Dio()
    .get(
      'https://booking-com.p.rapidapi.com/v1/static/hotels',
      options: Options(
        headers: {
          'X-RapidAPI-Key': 'c807de0302msh714ba343d5f6c4ap1d70cfjsn67868ef67b38',
          'X-RapidAPI-Host': 'booking-com.p.rapidapi.com'
        },
      ),
    );

    log(">> results =" + response.statusCode.toString());

    if (response.statusCode == 200) {
      List<HotelModel> hotels = (response.data as List)
        .map((e) => HotelModel(
          name: e['name'], 
          address: e['address'], 
          description: e['description']
        )).toList();
      return hotels;  
    } else {
      throw Exception('Failed to load hotels');
    }
  
  }
  
}

/* const options = {
  method: 'GET',
  url: 'https://booking-com.p.rapidapi.com/v1/static/hotels',
  params: {page: '0'},
  headers: {
    'X-RapidAPI-Key': 'c807de0302msh714ba343d5f6c4ap1d70cfjsn67868ef67b38',
    'X-RapidAPI-Host': 'booking-com.p.rapidapi.com'
  }
};

axios.request(options).then(function (response) {
	console.log(response.data);
}).catch(function (error) {
	console.error(error);
}); */