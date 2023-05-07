import 'package:flutter_test/flutter_test.dart';
import '../lib/model/api/hotel_api.dart';

void main() {
  
  group('Fetch Hotel or Inn API in RapidAPI', () { 
    test('fetch all inn popular', () async {
      final inns = await innAPi.getSearchinn(
        checkin: '2023-05-10',
        checkout: '2023-05-11',
        ordersBy: 'popularity',
      );
      expect(inns.length, 20);
    });

    test('fetch all local INN', () async {
      final inns = await LocalInn.getExploreInn(ordersBy: "review_score");
      expect(inns.length, 20);
    });

    test('fetch all hotel', () async {
      final hotels = await HotelAPI.getAllHotel();
      expect(hotels.length, 500);
      // expect(hotels[0].name, 'Hotel Indonesia Kempinski Jakarta');
    });
  
  });
}
