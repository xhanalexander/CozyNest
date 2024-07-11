import 'package:cozynest/model/api/hotel_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  
  group('Fetch Hotel or Inn API in RapidAPI', () { 
    test('fetch all inn popular', () async {
      final inns = await innAPi.getSearchinn(
        checkin: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        checkout: DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 1))),
        ordersBy: 'popularity',
      );
      expect(inns.length, 20);
    });

    test('fetch all local INN', () async {
      final inns = await LocalInn.getExploreInn(
        ordersBy: "review_score",
        checkIn: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        checkOuts: DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 1))),
      );
      expect(inns.length, 20);
    });

    test('fetch all hotel', () async {
      final hotels = await HotelAPI.getAllHotel();
      expect(hotels.length, 500);
      // expect(hotels[0].name, 'Hotel Indonesia Kempinski Jakarta');
    });
  
  });
}
