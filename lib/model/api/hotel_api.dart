import 'package:dio/dio.dart';
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
            'X-RapidAPI-Key': 'c807de0302msh714ba343d5f6c4ap1d70cfjsn67868ef67b38',
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
            'X-RapidAPI-Key': 'c807de0302msh714ba343d5f6c4ap1d70cfjsn67868ef67b38',
            'X-RapidAPI-Host': 'booking-com.p.rapidapi.com',
          },
        ),
      );

      // log('response: ${response.data}');
      
      if (response.statusCode == 200) {
        final datas = response.data['result'];
        List<InnModel> inns = List<InnModel>.from(datas.map((model) {
          InnModel x = InnModel.fromJson(model);
          return x;
        }));
        return inns;
      } else {
        throw Exception('Failed to load Inn');
      }
    } catch (e) {
      throw Exception('Failed to load Inn: $e');
    }
  }
}

class LocalInn {
  static const String URL_inn = 'https://booking-com.p.rapidapi.com/v1/hotels/search';

  static Future<List<InnModel>> getExploreInn({required String ordersBy, required String checkOuts, required String checkIn}) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        URL_inn,
        queryParameters: {
          'checkin_date': checkIn,
          'dest_type': "district",
          'units': 'metric',
          'checkout_date': checkOuts,
          'adults_number': 2,
          'order_by': ordersBy,
          'dest_id': 2067,
          'filter_by_currency': 'IDR',
          'locale': 'id',
          'room_number': 1,
        },
        options: Options(
          headers: {
            'X-RapidAPI-Key': 'c807de0302msh714ba343d5f6c4ap1d70cfjsn67868ef67b38',
            'X-RapidAPI-Host': 'booking-com.p.rapidapi.com',
          },
        ),
      );
      
      if (response.statusCode == 200) {
        final datas = response.data['result'];
        List<InnModel> inns = List<InnModel>.from(datas.map((model) {
          InnModel x = InnModel.fromJson(model);
          return x;
        }));
        return inns;
      } else {
        throw Exception('Failed to load Inn');
      }
    } catch (e) {
      throw Exception('Failed to load Inn: $e');
    }
  }
}